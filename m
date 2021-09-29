Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B47C433F5
	for <linux-hardening@archiver.kernel.org>; Wed, 29 Sep 2021 19:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 702D961528
	for <linux-hardening@archiver.kernel.org>; Wed, 29 Sep 2021 19:11:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346446AbhI2TMm (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 29 Sep 2021 15:12:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:46342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346211AbhI2TMl (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 29 Sep 2021 15:12:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A4F8461526;
        Wed, 29 Sep 2021 19:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632942660;
        bh=g/8s55Jc9bqt8ZNNteEuzgrzOaKJ/elKL6Rcokeb5XM=;
        h=Date:From:To:Cc:Subject:From;
        b=nXFeiZPSW79r4UtpWMpAj+sFQtFDItw0Azdkv+bcgqAhlqsNY1rIMFzeJg0E7AOSL
         GGu092Vwb+B8Zt66Dd9akCOdAQvl3OY6aYceGqV3pxbJuAGIkSdxbV/MNqD2KFhu3T
         /7NbpFrr3sVtXygweNooeksB8BgKwFl5i9ggQhKmF7iWNj6jC9yjwHkRG/tzHnLdNx
         K4Xv8A8njMCu+Idbn8Qw3uojter5eeOMewy7T24AH+8FsPdwDK8As8WQalcTgI2CUo
         dDvWtlydXy2hkheMpF31hBm/d5sop6hyYl6WolfVTVwbkDyYm+995y/SnXJbN4pNh3
         ZHTzk8/g/jVpA==
Date:   Wed, 29 Sep 2021 14:15:04 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Anton Yakovlev <anton.yakovlev@opensynergy.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     virtualization@lists.linux-foundation.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] ALSA: virtio: Replace zero-length array with
 flexible-array member
Message-ID: <20210929191504.GA337268@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

There is a regular need in the kernel to provide a way to declare
having a dynamically sized set of trailing elements in a structure.
Kernel code should always use “flexible array members”[1] for these
cases. The older style of one-element or zero-length arrays should
no longer be used[2].

Also, make use of the struct_size() helper in kzalloc().

[1] https://en.wikipedia.org/wiki/Flexible_array_member
[2] https://www.kernel.org/doc/html/v5.10/process/deprecated.html#zero-length-and-one-element-arrays

Link: https://github.com/KSPP/linux/issues/78
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 sound/virtio/virtio_pcm_msg.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/virtio/virtio_pcm_msg.c b/sound/virtio/virtio_pcm_msg.c
index f88c8f29cbd8..aca2dc1989ba 100644
--- a/sound/virtio/virtio_pcm_msg.c
+++ b/sound/virtio/virtio_pcm_msg.c
@@ -20,7 +20,7 @@ struct virtio_pcm_msg {
 	struct virtio_snd_pcm_xfer xfer;
 	struct virtio_snd_pcm_status status;
 	size_t length;
-	struct scatterlist sgs[0];
+	struct scatterlist sgs[];
 };
 
 /**
@@ -146,8 +146,7 @@ int virtsnd_pcm_msg_alloc(struct virtio_pcm_substream *vss,
 		int sg_num = virtsnd_pcm_sg_num(data, period_bytes);
 		struct virtio_pcm_msg *msg;
 
-		msg = kzalloc(sizeof(*msg) + sizeof(*msg->sgs) * (sg_num + 2),
-			      GFP_KERNEL);
+		msg = kzalloc(struct_size(msg, sgs, sg_num + 2), GFP_KERNEL);
 		if (!msg)
 			return -ENOMEM;
 
-- 
2.27.0

