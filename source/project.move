module MyModule::VotingSystem {

    use aptos_framework::signer;
    use std::vector;
    use aptos_framework::account;

    /// Struct representing a voting poll.
    struct Poll has key, store {
        question: vector<u8>,  // The poll question
        votes_yes: u64,        // Count of "Yes" votes
        votes_no: u64,         // Count of "No" votes
    }

    /// Function to create a new poll with a question.
    public fun create_poll(owner: &signer, question: vector<u8>) {
        let poll = Poll {
            question,
            votes_yes: 0,
            votes_no: 0,
        };
        move_to(account::address_of(owner), poll);
    }

    /// Function to cast a vote (true for Yes, false for No).
    public fun cast_vote(owner: &signer, vote: bool) acquires Poll {
        let poll = borrow_global_mut<Poll>(account::address_of(owner));
        if (vote) {
            poll.votes_yes = poll.votes_yes + 1;
        } else {
            poll.votes_no = poll.votes_no + 1;
        }
    }
}
