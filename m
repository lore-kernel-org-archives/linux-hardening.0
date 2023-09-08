Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 433B0EEB566
	for <linux-hardening@archiver.kernel.org>; Fri,  8 Sep 2023 20:03:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234042AbjIHUDw (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 8 Sep 2023 16:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232883AbjIHUDw (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 8 Sep 2023 16:03:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0715A122
        for <linux-hardening@vger.kernel.org>; Fri,  8 Sep 2023 13:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694203366;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=CVUWiNi0XyDqlB1JxyjZ0R/Ir5gIUCrvEGnFOU6/cQM=;
        b=i3XSc3IbHxg4+9Y4Xt7yiR9jYIWtiHtn5K5lokvFfE0pPMuAwIsdbFomCnx2WuXphQzZm/
        O4hCWC4JByje5ob91Se3AAukS/Btccfx4SSK4UAy33/ox97iQLoJ4CIN/Kq/ygq1ravGcJ
        i5f/lARzV5s4WHVjccg1QMz3rwesbXs=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-vTjUD3DlMoCT6uCAa2qjAQ-1; Fri, 08 Sep 2023 16:02:43 -0400
X-MC-Unique: vTjUD3DlMoCT6uCAa2qjAQ-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4122119722eso4980291cf.0
        for <linux-hardening@vger.kernel.org>; Fri, 08 Sep 2023 13:02:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694203362; x=1694808162;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CVUWiNi0XyDqlB1JxyjZ0R/Ir5gIUCrvEGnFOU6/cQM=;
        b=GGviZ3QmAlZBIYVDuq9tg69v/Q+ZrXoYUsS0rrZxPb1PdzuK7yQ2fQuj5yHuMFVdm7
         K92puBNKo39KSleGXTus/pybFg99s6cYb0b4I7mxJpUF2cvZGlwDxaCnzlx539eI5P+a
         qiehnKh3GWRRIzjkA3DuJfCOYLk/X4ujxZJW1snVYb3Ka37N/EbdbzujCaFf6+aEvuRI
         wEXQBEXQXnLv7p/nhTnXKBaKxpiACbCy9Lsp8GxmC7nA2BffJvtBj/U6wUa0E4Y4ueo6
         PU7iUKttbb76c/WLfWoU+F9bECLyU4xIFfwIoKL+ASQ0/jC8PLGqvWBiP5GJHc1MyfB8
         O7Eg==
X-Gm-Message-State: AOJu0YzMDF8/DHvWceoZLk+VEY7mjtL1hW5/1/iVq5viD6HZnqL7ffWf
        8ptmUhUqT+GSOhcyA8Bw1K7T8yCxdwsnXusT3DyA8vCyZ8E7JdyW4kpZJzi4Jm1OSF9gBNhnv+S
        WSKD+PHYlTLFenJT2LQxPorktO5DP
X-Received: by 2002:a05:622a:1915:b0:412:1c5f:4781 with SMTP id w21-20020a05622a191500b004121c5f4781mr4701197qtc.4.1694203362645;
        Fri, 08 Sep 2023 13:02:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEuiGnmMFWAKLSh30zPQGkgvOkX4VTvQk/17jsSVc5WjoNTNjt80rBc5lL7G+qjPScKuI3czQ==
X-Received: by 2002:a05:622a:1915:b0:412:1c5f:4781 with SMTP id w21-20020a05622a191500b004121c5f4781mr4701161qtc.4.1694203362351;
        Fri, 08 Sep 2023 13:02:42 -0700 (PDT)
Received: from fedorinator.redhat.com ([2001:9e8:32da:e500:513e:fbe9:e455:ae67])
        by smtp.gmail.com with ESMTPSA id jm8-20020a05622a750800b003f9c6a311e1sm840078qtb.47.2023.09.08.13.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 13:02:42 -0700 (PDT)
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
Subject: [PATCH v2 0/5] Introduce new wrappers to copy user-arrays
Date:   Fri,  8 Sep 2023 21:59:39 +0200
Message-ID: <cover.1694202430.git.pstanner@redhat.com>
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


Changes since v1:
- Insert new headers alphabetically ordered
- Remove empty lines in functions' docstrings
- Return -EOVERFLOW instead of -EINVAL from wrapper functions


@Andy:
I test-build it for UM on my x86_64. Builds successfully.
A kernel build (localmodconfig) for my Fedora38 @ x86_64 does also boot
fine.

If there is more I can do to verify the early boot stages are fine,
please let me know!

P.

Philipp Stanner (5):
  string.h: add array-wrappers for (v)memdup_user()
  kernel: kexec: copy user-array safely
  kernel: watch_queue: copy user-array safely
  drm_lease.c: copy user-array safely
  drm: vmgfx_surface.c: copy user-array safely

 drivers/gpu/drm/drm_lease.c             |  4 +--
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c |  4 +--
 include/linux/string.h                  | 40 +++++++++++++++++++++++++
 kernel/kexec.c                          |  2 +-
 kernel/watch_queue.c                    |  2 +-
 5 files changed, 46 insertions(+), 6 deletions(-)

-- 
2.41.0

