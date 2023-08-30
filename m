Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586BCC83F18
	for <linux-hardening@archiver.kernel.org>; Wed, 30 Aug 2023 18:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242002AbjH3S4o (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 30 Aug 2023 14:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244705AbjH3NrN (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 30 Aug 2023 09:47:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6456BA3
        for <linux-hardening@vger.kernel.org>; Wed, 30 Aug 2023 06:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693403184;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=PzqfQ88022ZJBnlN9XJGH4Rch2pPLUTbjECBn8E9VEk=;
        b=DN1Tqt3clHoxo73R7PnSFAqo34lXpu9aMaVFTHaXY+k8j/7veF9a9AoZ7DRb76NbhZ6lMe
        3qJ8eetD6X5J52uXnz2OtdzJLmi3D7Qc8aQ7W8+ykB3RN5zkrHyA8aYY4Z1HGTvF7iw5D7
        /2lMY1nmDC4Z0S9lnxE60m1ksFaBv6s=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-QQgWt3W7MTSoVfeBQbbUzA-1; Wed, 30 Aug 2023 09:46:23 -0400
X-MC-Unique: QQgWt3W7MTSoVfeBQbbUzA-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2b6fdb8d0acso19451841fa.0
        for <linux-hardening@vger.kernel.org>; Wed, 30 Aug 2023 06:46:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693403181; x=1694007981;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PzqfQ88022ZJBnlN9XJGH4Rch2pPLUTbjECBn8E9VEk=;
        b=ClfjOIyqpGRYD7gQEKdbLAStVgwPIGQdJHgr8sSDSHNK//u9+6E5B6ZJQBgdre9zPI
         mDAJBAwtKFxUSPlxoS+jiN6yi+MjYhmYj1beo2X3UFwyw9XGQb29zIcte8wm5DzL5Lyw
         RO7gjkRGDtCtcOCQe8zpFqk7mpJ3C8VfG2VtRfLjhfj2BKEXceQWE2NBtwmOsrxEzrrV
         rS93OwmON36PuIZjWtkuGdmHID9rXUN1tQr07xvG9ayZIocIPKGByLfNCQBB75ECiOuk
         0YVe5T/NFQKVCpj+KFwSv4DE6Y+2n2d9KBZeQ2FGPD66+tFhFJ+TZCtgwGqh6JqQFoyP
         ciKw==
X-Gm-Message-State: AOJu0YzLBaXZxZ0T5LRfMgdJS6YtfAaH2yRxG6XjaRTRYrJdox1osOeA
        kp7d1+mkpeH8pLTXnpFsmwex6ncD6L20LKdeDCESEGtP2uCaQPUkwxoo60Y4t7fsIsBLT2GXuF/
        gZqXmCXwdsrsZ7Sb+BOpn2e3tBFoV
X-Received: by 2002:a05:651c:201b:b0:2bb:8d47:9d95 with SMTP id s27-20020a05651c201b00b002bb8d479d95mr1564045ljo.2.1693403181696;
        Wed, 30 Aug 2023 06:46:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFj7gH1IKBMS0NWbE4Xd4vUNDX4WI+F2xE2mn0UylTciMqkBXPKro8KLHlIW5rak33HRcstNQ==
X-Received: by 2002:a05:651c:201b:b0:2bb:8d47:9d95 with SMTP id s27-20020a05651c201b00b002bb8d479d95mr1564026ljo.2.1693403181300;
        Wed, 30 Aug 2023 06:46:21 -0700 (PDT)
Received: from fedorinator.fritz.box ([2001:9e8:32e4:1500:aa40:e745:b6c9:7081])
        by smtp.gmail.com with ESMTPSA id t26-20020a1709063e5a00b009829dc0f2a0sm7174346eji.111.2023.08.30.06.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 06:46:20 -0700 (PDT)
From:   Philipp Stanner <pstanner@redhat.com>
To:     Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andy@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Christian Brauner <brauner@kernel.org>,
        David Disseldorp <ddiss@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Siddh Raman Pant <code@siddh.me>,
        Nick Alcock <nick.alcock@oracle.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Zack Rusin <zackr@vmware.com>
Cc:     VMware Graphics Reviewers <linux-graphics-maintainer@vmware.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, linux-hardening@vger.kernel.org,
        Philipp Stanner <pstanner@redhat.com>
Subject: [PATCH 0/5] Introduce new wrappers to copy user-arrays
Date:   Wed, 30 Aug 2023 15:45:51 +0200
Message-ID: <cover.1693386602.git.pstanner@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi!

David Airlie suggested that we could implement new wrappers around
(v)memdup_user() for duplicating user arrays.

This small patch series first implements the two new wrapper functions
memdup_array_user() and vmemdup_array_user(). They calculate the
array-sizes safely, i.e., they return an error in case of an overflow.

It then implements the new wrappers in two components in kernel/ and two
in the drm-subsystem.

In total, there are 18 files in the kernel that use (v)memdup_user() to
duplicate arrays. My plan is to provide patches for the other 14
successively once this series has been merged.

P.

Philipp Stanner (5):
  string.h: add array-wrappers for (v)memdup_user()
  kernel: kexec: copy user-array safely
  kernel: watch_queue: copy user-array safely
  drm_lease.c: copy user-array safely
  drm: vmgfx_surface.c: copy user-array safely

 drivers/gpu/drm/drm_lease.c             |  4 +--
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c |  4 +--
 include/linux/string.h                  | 42 +++++++++++++++++++++++++
 kernel/kexec.c                          |  2 +-
 kernel/watch_queue.c                    |  2 +-
 5 files changed, 48 insertions(+), 6 deletions(-)

-- 
2.41.0

