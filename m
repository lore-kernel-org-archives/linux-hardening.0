Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE61C49EB7
	for <linux-hardening@archiver.kernel.org>; Wed, 23 Jun 2021 20:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53D77610C7
	for <linux-hardening@archiver.kernel.org>; Wed, 23 Jun 2021 20:39:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhFWUmJ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 23 Jun 2021 16:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbhFWUmG (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 23 Jun 2021 16:42:06 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE28C061767
        for <linux-hardening@vger.kernel.org>; Wed, 23 Jun 2021 13:39:48 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id c8so3292451pfp.5
        for <linux-hardening@vger.kernel.org>; Wed, 23 Jun 2021 13:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Lnn9jp/s32hmkbL+/fflp0AYulLa8VCq66U0jv/eDes=;
        b=C1YmvtJB6ygrlO6e3yWlLKjc6iRwUSJaKCLlk6vJQ46k0QV+mgo5ZXBkqnx1ETI7Bo
         0ImQPtsKOnj13rIVcLAnUm4f4mWTuB9d6UG69Ymk9JjWlge3TjqC4Q1y3alDooeS3+2r
         vThLKpEt8iYquBxfy1ZwtfJBPAXkp9aG2u5k0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Lnn9jp/s32hmkbL+/fflp0AYulLa8VCq66U0jv/eDes=;
        b=LLt8MkKP8f50PUcjRQMiZBFHrl6FJdxJbRM6XSzHCBnNE+cXmfa+EpQnTTCKxMlKlj
         yi0z3GjSIhbvdGhwkaP2mWYYDmAl44AbMN30SrJZdRUTARf/bDiXNifIoBajJprM/IGE
         /sVLuGlX7Pl3pdtVjHiI7B61NT+a+kiLMvw7kNjUfn4O9K3yRP6epS/M76QrPnY0onwl
         n7i6zr0yoPocQAPVQj11fKkZduYwhIImzbJR2pFHebDyDutEg65oOItiwTAn3WIlITl9
         1905dmlAlhbatycdjeojox0paty0awtvKqtofqW5FRn8eKjDt4mV1sqypFsKpy7TOxtK
         UitA==
X-Gm-Message-State: AOAM533boRYvE0YrMFjbGNcGyMEthrVRz0ZnLum15W6BkkpqH+RMclhy
        mZiVmAyy59kKM56a+w1AXqovEA==
X-Google-Smtp-Source: ABdhPJy25JF5LfPlvMzjiFU6YxFBAIl/9LluZtx9nqJMnVqSL0stDwYx7dEMGfPl3SHI7ZOODjCkFw==
X-Received: by 2002:aa7:8254:0:b029:2ed:b41:fefc with SMTP id e20-20020aa782540000b02902ed0b41fefcmr1498913pfn.42.1624480788262;
        Wed, 23 Jun 2021 13:39:48 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 92sm6294061pjv.29.2021.06.23.13.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 13:39:45 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        kernelci@groups.io, linux-kselftest@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH 0/9] LKDTM: Improvements for kernelci.org
Date:   Wed, 23 Jun 2021 13:39:27 -0700
Message-Id: <20210623203936.3151093-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1469; h=from:subject; bh=zEuv0J1e6Ce2pKHimEyiAaIYYKWtyU0Hog/oTewgJ2Q=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBg05wFChS5JDlFBZpH8NNFzZZUwtqUxgF7CN0I4TwO T784QdeJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYNOcBQAKCRCJcvTf3G3AJkcxEA CluTxSMcPooRUNQtu6ITHy4aTzsPHZRIHL4Ygd6kjyDQO3ldSlcQafSvdwQdU9mmcXXkKfA4FU2E9Q VUiby+2TjqiTHS7GoDzvduYDAiJ2qTPK9eKfipp6zcwyrZEfXmFV0l1CBZIuab7G5uKq67+Nqx+j0G gAihVQFVrIDuP2xqSolSgSDZ4HDV7qRcpcOz4dp86mvfQyvp/vjTodFTYpSQaUWb54m9CKgmerG/Ki cw1JyjSGPQBCXev0rY4IyRn0WyUFzfa1DKIZnRMI6+up9iNTR1pKOCeqaP7q4+rHpJs9yCm40WlT8A AhF7CDUWj6J/ocghjGEByr+ObzUm/F5ip+eGRHPubl8oavMB2pBKov2vM+v6LTcJQkKMz82OFHU7P8 SLKxRr9PO5BSHuwCr80Ju0BqWRDohcjP3xK2j9hqvhzFCEhoIew9IDYZtAo1iqEAY5G5FA3m336cFW hc/U9lDeHJSo9RedWBRcTz8zLAQTYsnRz4QTdORHzmHhfc8VRVdQ5+HgYJqk4sSEt6JqKmH06zys0y L4zXmsaU4uuKIzVWtX89R1xPRARgF1FDUy4hFicEfL6TR7hpGzMdxcsv7jdn7CQUfbcgmrwkN01S9O 0SfggbzjvFahUpHkHC1b849WPAa/AinczkLUw1s9B21RYzD335XtCKHTAEjg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

This is a bunch of LKDTM clean-ups to improve and expand testing,
given feedback from testing at kernelci.org. Adds a few new tests as
well.

(If a pull-request is preferred, please let me know.)

Thanks!

-Kees

Kees Cook (9):
  selftests/lkdtm: Avoid needing explicit sub-shell
  selftests/lkdtm: Fix expected text for CR4 pinning
  selftests/lkdtm: Fix expected text for free poison
  lkdtm/bugs: XFAIL UNALIGNED_LOAD_STORE_WRITE
  lkdtm/heap: Add vmalloc linear overflow test
  lkdtm: Enable DOUBLE_FAULT on all architectures
  lkdtm: Add CONFIG hints in errors where possible
  selftests/lkdtm: Enable various testable CONFIGs
  lkdtm/heap: Add init_on_alloc tests

 drivers/misc/lkdtm/bugs.c                     | 11 ++-
 drivers/misc/lkdtm/cfi.c                      |  3 +-
 drivers/misc/lkdtm/core.c                     | 58 ++++++++++-
 drivers/misc/lkdtm/fortify.c                  |  3 +-
 drivers/misc/lkdtm/heap.c                     | 97 ++++++++++++++++++-
 drivers/misc/lkdtm/lkdtm.h                    | 46 ++++++++-
 drivers/misc/lkdtm/stackleak.c                |  4 +-
 drivers/misc/lkdtm/usercopy.c                 |  7 +-
 tools/testing/selftests/lkdtm/config          |  7 ++
 tools/testing/selftests/lkdtm/run.sh          | 12 ++-
 .../testing/selftests/lkdtm/stack-entropy.sh  |  1 +
 tools/testing/selftests/lkdtm/tests.txt       | 11 ++-
 12 files changed, 236 insertions(+), 24 deletions(-)

-- 
2.30.2

