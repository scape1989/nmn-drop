local parser = {
//   boolparser(x): true if x == "true" else False,
  boolparser(x):
    if x == "true" then true
    else false,
};

local parse_number(x) =
  local a = std.split(x, ".");
  if std.length(a) == 1 then
    std.parseInt(a[0])
  else
    local denominator = std.pow(10, std.length(a[1]));
    local numerator = std.parseInt(a[0] + a[1]);
    local parsednumber = numerator / denominator;
    parsednumber;


{
  "dataset_reader": {
    "type": std.extVar("DATASET_READER"),
    "lazy": true,

    "sentence_token_indexers": {
      "tokens": {
        "type": "single_id",
        "lowercase_tokens": true,
        "namespace": "tokens"
      }
    }
  },

  "vocabulary": {
    "directory_path": std.extVar("VOCABDIR")
  },

  "train_data_path": std.extVar("TRAINING_DATA_FILE"),
  "validation_data_path": std.extVar("VAL_DATA_FILE"),
//  "test_data_path": std.extVar("testfile"),


  "model": {
    "type": "sample_hotpot_parser",

    "question_embedder": {
      "tokens": {
        "type": "embedding",
        "vocab_namespace": "tokens",
        "embedding_dim": 25,
        "trainable": true
      }
    },

    "action_embedding_dim": 50,

    "encoder": {
      "type": "lstm",
      "input_size": 25,
      "hidden_size": 10,
      "num_layers": 1
    },

    "attention": {"type": "dot_product"},

    "decoder_beam_search": {
      "beam_size": parse_number(std.extVar("BEAMSIZE")),
    },

    "beam_size": parse_number(std.extVar("BEAMSIZE")),
    "max_decoding_steps": parse_number(std.extVar("MAX_DECODE_STEP")),
    "dropout": parse_number(std.extVar("DROPOUT")),
  },

  "iterator": {
    "type": "basic",
    "batch_size": std.extVar("BS"),
    "max_instances_in_memory": 16 //
  },

  "trainer": {
    "grad_clipping": 10.0,
    "cuda_device": 0,
    "num_epochs": 15,
    "shuffle": false,
    "optimizer": {
      "type": "adam",
      "lr": parse_number(std.extVar("LR"))
    },
    "summary_interval": 10,
    // "validation_metric": "+multspan_acc"
  },

  "random_seed": 100,
  "numpy_seed": 100,
  "pytorch_seed": 100

}