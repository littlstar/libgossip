
/**
 * `survey.h'
 *
 * copyright (c) 2014 - joseph werle <joseph.werle@gmail.com>
 */

#ifndef GOSSIP_SURVEY_H
#define GOSSIP_SURVEY_H

#import "common.h"
#import "socket.h"

@interface GossipSurvey : GossipSocket

  /**
   * Send out survey and read response in block
   */

  - (id) survey: (const char *) message
       response: (GossipSocketReceiveBlock) block;

  /**
   * Request survey from server
   */

  - (id) request: (GossipSocketReceiveBlock) block;

  /**
   * Responsd with message
   */

  - (int) respond: (const char *) message;

@end

#endif
