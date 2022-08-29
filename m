Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A7BBECAAD2
	for <linux-hardening@archiver.kernel.org>; Mon, 29 Aug 2022 21:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbiH2VwN (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 29 Aug 2022 17:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiH2VwL (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 29 Aug 2022 17:52:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62FC9F8F0;
        Mon, 29 Aug 2022 14:52:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82708612A0;
        Mon, 29 Aug 2022 21:52:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF3DEC43147;
        Mon, 29 Aug 2022 21:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661809929;
        bh=SLuDKCSxqiHHDmnwI3+58YA9f0120J1/hz6TFh+Tap4=;
        h=Date:From:To:Cc:Subject:From;
        b=A63hqZQ7KTiL4okMhc6hTVpb6ErLGiUIk4+WN4Nphl6T64TEAGF+8dqUIhP27Gbih
         hZv0pfr+ZoFWsA/39vyd80zby7RFugYSA75SfVP0YOLs/qALtf9EOc4N9STMXCKwLB
         uwlUuEFvEfP2L9Rypr5tVY3uuZ8tiHluuho4EUvzSn67qZ/rAneVlJlnFPWNPbNqBt
         xK0bJSN1+ZeR6DbIGQ6oEhNozVcFqTJ1h0kU1ZU/AM3acPUw5qoVjx9ig8cl3NpOod
         bNWRrtZCHYYEhSKkE8iugEKc37PIungBP7bsoh1LkSrYWN6YmTFUJqgqZR5DcmZI5x
         QItokQItp8okA==
Date:   Mon, 29 Aug 2022 16:52:03 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] ALSA: hda/hdmi: Replace zero-length array with
 DECLARE_FLEX_ARRAY() helper
Message-ID: <Yw01A+TvF1FWQ588@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Zero-length arrays are deprecated and we are moving towards adopting
C99 flexible-array members, instead. So, replace zero-length array
declaration in union audio_infoframe with the new DECLARE_FLEX_ARRAY()
helper macro.

This helper allows for a flexible-array member in a union.

Link: https://github.com/KSPP/linux/issues/193
Link: https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 sound/pci/hda/patch_hdmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 6c209cd26c0c..2191d445d74e 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -229,7 +229,7 @@ struct dp_audio_infoframe {
 union audio_infoframe {
 	struct hdmi_audio_infoframe hdmi;
 	struct dp_audio_infoframe dp;
-	u8 bytes[0];
+	DECLARE_FLEX_ARRAY(u8, bytes);
 };
 
 /*
-- 
2.34.1

