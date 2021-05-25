Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EBA6C47087
	for <linux-hardening@archiver.kernel.org>; Tue, 25 May 2021 23:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74933613F6
	for <linux-hardening@archiver.kernel.org>; Tue, 25 May 2021 23:14:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbhEYXQQ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 25 May 2021 19:16:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:36214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229610AbhEYXQP (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 25 May 2021 19:16:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 143226128B;
        Tue, 25 May 2021 23:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621984485;
        bh=/EdwyLQ+0LUXTaPyhPRLe2zoHvEb5leoOHuBg++UM1o=;
        h=Date:From:To:Cc:Subject:From;
        b=XOokvxXL/+Si6if87jIxVJLjCObnqn3ReG/G14b29kGq1OSabBmWJpLVkevuEKedY
         PTOw75MfoetLGNDb/bhJgoMKVy0ULwN+XQypsauhnOZ+N5pt1azVEXWUv8HIW3L76c
         +zAb2cmcdgxqmtz48WEdOGTQ8yr0lnwT3Z1zG3vYQfC+xrzWUoQFu25ys9F48uL7ZW
         f3+WPqWcR8p8DU3EenOKYkqFhc5K5RCBjMXHUPjlrEBn+k8L5vJ4hvsqTu4hBhkbrg
         UnZxl0PRVBxiAQSXjvfOS9IEfjwA2BtvloDdJGqvwCHfZp6vIIgz0Rrtad2llGe0Lu
         cL41sXnxe0xIQ==
Date:   Tue, 25 May 2021 18:15:42 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>
Cc:     intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] virtchnl: Replace one-element array in struct
 virtchnl_irq_map_info
Message-ID: <20210525231542.GA176299@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

There is a regular need in the kernel to provide a way to declare having a
dynamically sized set of trailing elements in a structure. Kernel code
should always use “flexible array members”[1] for these cases. The older
style of one-element or zero-length arrays should no longer be used[2].

Refactor the code according to the use of a flexible-array member in struct
virtchnl_irq_map_info instead of one-element array, and use the
flex_array_size() helper.

[1] https://en.wikipedia.org/wiki/Flexible_array_member
[2] https://www.kernel.org/doc/html/v5.10/process/deprecated.html#zero-length-and-one-element-arrays

Link: https://github.com/KSPP/linux/issues/79
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 include/linux/avf/virtchnl.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/avf/virtchnl.h b/include/linux/avf/virtchnl.h
index ed9c4998f8ac..7ded2b454122 100644
--- a/include/linux/avf/virtchnl.h
+++ b/include/linux/avf/virtchnl.h
@@ -378,10 +378,10 @@ VIRTCHNL_CHECK_STRUCT_LEN(12, virtchnl_vector_map);
 
 struct virtchnl_irq_map_info {
 	u16 num_vectors;
-	struct virtchnl_vector_map vecmap[1];
+	struct virtchnl_vector_map vecmap[];
 };
 
-VIRTCHNL_CHECK_STRUCT_LEN(14, virtchnl_irq_map_info);
+VIRTCHNL_CHECK_STRUCT_LEN(2, virtchnl_irq_map_info);
 
 /* VIRTCHNL_OP_ENABLE_QUEUES
  * VIRTCHNL_OP_DISABLE_QUEUES
@@ -1008,8 +1008,8 @@ virtchnl_vc_validate_vf_msg(struct virtchnl_version_info *ver, u32 v_opcode,
 		if (msglen >= valid_len) {
 			struct virtchnl_irq_map_info *vimi =
 			    (struct virtchnl_irq_map_info *)msg;
-			valid_len += (vimi->num_vectors *
-				      sizeof(struct virtchnl_vector_map));
+			valid_len += flex_array_size(vimi, vecmap,
+						     vimi->num_vectors);
 			if (vimi->num_vectors == 0)
 				err_msg_format = true;
 		}
-- 
2.27.0

