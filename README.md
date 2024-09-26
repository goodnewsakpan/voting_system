# Decentralized Voting System Smart Contract

## Overview

This repository contains a Clarity smart contract implementing a decentralized voting system on the Stacks blockchain. The contract allows for the creation of a simple voting mechanism where candidates can be added, users can cast votes, and voting can be opened or closed by the contract owner.

## Features

- Add candidates to the voting system
- Cast votes for candidates
- Retrieve vote counts for individual candidates
- Check if a user has already voted
- Get the total number of votes cast
- Open and close voting periods
- Retrieve candidate information

## Contract Details

### Constants

- `CONTRACT_OWNER`: The principal who deployed the contract and has special privileges.
- Error codes for various scenarios (e.g., unauthorized access, already voted, invalid vote, voting closed).

### Data Variables

- `voting-open`: A boolean indicating whether voting is currently open.
- `total-votes`: The total number of votes cast.

### Data Maps

- `votes`: Maps voter principals to their chosen candidate IDs.
- `candidates`: Stores candidate information, including name and vote count.

### Functions

#### Read-Only Functions

1. `get-vote-count`: Retrieves the vote count for a specific candidate.
2. `get-total-votes`: Returns the total number of votes cast.
3. `has-voted`: Checks if a specific voter has already cast a vote.
4. `is-voting-open`: Checks if voting is currently open.
5. `get-candidate`: Retrieves information about a specific candidate.

#### Public Functions

1. `add-candidate`: Allows the contract owner to add a new candidate.
2. `vote`: Allows a user to cast a vote for a candidate.
3. `close-voting`: Allows the contract owner to close the voting.
4. `reopen-voting`: Allows the contract owner to reopen the voting.

## Usage

### Deploying the Contract

To deploy this contract, you'll need to use the Stacks CLI or a development environment like Clarinet. Ensure you have the necessary tools installed and configured.

```bash
clarinet contract:deploy voting-system
```

### Interacting with the Contract

Here are some example interactions with the contract:

1. Adding a candidate (only contract owner):
   ```clarity
   (contract-call? .voting-system add-candidate u4 "New Candidate")
   ```

2. Casting a vote:
   ```clarity
   (contract-call? .voting-system vote u1)
   ```

3. Checking the vote count for a candidate:
   ```clarity
   (contract-call? .voting-system get-vote-count u1)
   ```

4. Closing the voting (only contract owner):
   ```clarity
   (contract-call? .voting-system close-voting)
   ```

## Security Considerations

- Only the contract owner can add candidates, close, and reopen voting.
- Users can only vote once.
- Voting is only allowed when the voting period is open.

## Future Enhancements

Potential improvements to the contract could include:

1. Implementing a function to get all candidates.
2. Adding a function to determine the winning candidate.
3. Implementing time-based voting using block height.
4. Allowing candidates to register themselves with a stake.

## License

[Specify your chosen license here, e.g., MIT, Apache 2.0, etc.]

## Contributing

We welcome contributions to improve this smart contract. Please feel free to submit issues, fork the repository and send pull requests!