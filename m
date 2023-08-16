Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 827EBC04E69
	for <linux-hardening@archiver.kernel.org>; Wed, 16 Aug 2023 18:03:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234974AbjHPSCi (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 16 Aug 2023 14:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345377AbjHPSCV (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 16 Aug 2023 14:02:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9DB2D4E;
        Wed, 16 Aug 2023 11:02:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD53061248;
        Wed, 16 Aug 2023 18:02:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35EC3C433C7;
        Wed, 16 Aug 2023 18:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692208925;
        bh=gp3yZZEYckBcBiq4VFVIch47+nBca1xYajti9VUSwiI=;
        h=Date:From:To:Cc:Subject:From;
        b=HBWJCVNUjtLnjIq8WbmJ2KGhH+Kd7ZW9c3uIHfULCLaiVFas0AR7vH0HmvENgyIiv
         tB8w0MflSTiexZe2Jx7YA+npAHAxRSy/sPomD/YPO7JQrBNY5m2jMSHvQ/DjeE1rFA
         BEHdJTWG5Qspj3bn0WMUS6AMEAAcTNKYb05Luu+QFRHcuTlbYC+JkU36dUDt0VS0Ti
         oq0WTMdD7IdOCLr7kMbz+fYq3ZITmkBI7fPuCgJI4VJ/ifMB2heemvLgZQWvn8wxqc
         +wXYcc4r0VRUoy/+1b//G4oBQWnrt74O8tF0B26JhrzLjJeTEHhvDFzQAgVP+Q8RoP
         v719CEBxHNTzA==
Date:   Wed, 16 Aug 2023 12:03:06 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Ben Skeggs <bskeggs@redhat.com>, Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH 0/2][next] nouveau/svm: Replace one-element array with
 flexible-array member
Message-ID: <cover.1692208802.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

This small series aims to replace a one-element array with a
flexible-array member in struct nouveau_svm. And, while at it,
fix a checkpatch.pl error.

Gustavo A. R. Silva (2):
  nouveau/svm: Replace one-element array with flexible-array member in
    struct nouveau_svm
  nouveau/svm: Split assignment from if conditional

 drivers/gpu/drm/nouveau/nouveau_svm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

-- 
2.34.1

