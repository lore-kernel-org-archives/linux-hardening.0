Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D375C4708C
	for <linux-hardening@archiver.kernel.org>; Tue,  6 Dec 2022 15:24:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234156AbiLFPYP (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 6 Dec 2022 10:24:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234508AbiLFPYL (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 6 Dec 2022 10:24:11 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EECED10A1
        for <linux-hardening@vger.kernel.org>; Tue,  6 Dec 2022 07:24:06 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d3so14233352plr.10
        for <linux-hardening@vger.kernel.org>; Tue, 06 Dec 2022 07:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=++VLLdD5R20NP2dhD9BoY4L3MuuVmiuDtlzNl1iSWtk=;
        b=cAilTNJHTAFkJQytHoH0SGB+6dKp6ndnZajpjXOAv2UO5kipCER/TNgAJmTUJcESYl
         VUtyRMqplbj+tD36ohI0lETkbFfIKMTDdyDeb35cYkms3sWCP6VCM94uPzi4In9LmbJv
         +2POC21Bj9oHiGiVhRrHZxnizizh3iJoxjf10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=++VLLdD5R20NP2dhD9BoY4L3MuuVmiuDtlzNl1iSWtk=;
        b=IuKgGqUCnnIq1MGkaRsf2RfqdauT11sD4d6BoBE4SWeDXMB5ZK+oLMoSz0tHsi5KgE
         W69jeOT/EmSXUR9by1igTPlfCZSqBgKJ1PDHIuRlekha4a6Ps8JAVrMvnuh0lHCws7Kn
         jJvsAb2UePjenp4ppdpAV7Y9yX5QKD4Pa2P//eFv4t7DD4jTW5HNhnkiPk8waImmrApp
         ScJkcSNNm5di+yXstGMPk2SJWhIM5lnKNb+5xaKibhmyVmXsP3q2sR8KUAC4ndXK8SX1
         y6k0HQXA6yZJiEU2suVHuszvdbn2h3SSU2Rf+6jG/MZha0G1woT09BC/BPYCWoedQWYb
         klBg==
X-Gm-Message-State: ANoB5plUyEhj64xaWewkUyOLmDE6TPVznH1IeETdrtqGYH2mmcDZ9hJa
        CWQb0JKgl9/nsC8LMAxckAc+YQ==
X-Google-Smtp-Source: AA0mqf7aeZ4dvXiSU9Z+VNjS+yr8ocnkAalGIxhJS9tP4tTJN8fDvVoJBtGSW7msaJjFp5VgNQFYmQ==
X-Received: by 2002:a17:902:ccc3:b0:189:808b:c659 with SMTP id z3-20020a170902ccc300b00189808bc659mr46888465ple.13.1670340246644;
        Tue, 06 Dec 2022 07:24:06 -0800 (PST)
Received: from jeffxud.c.googlers.com.com (30.202.168.34.bc.googleusercontent.com. [34.168.202.30])
        by smtp.gmail.com with ESMTPSA id r25-20020a635d19000000b0046b1dabf9a8sm10004686pgb.70.2022.12.06.07.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 07:24:05 -0800 (PST)
From:   jeffxu@chromium.org
To:     skhan@linuxfoundation.org, keescook@chromium.org
Cc:     akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, hughd@google.com, jeffxu@google.com,
        jorgelo@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        jannh@google.com, linux-hardening@vger.kernel.org,
        Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v5 4/6] mm/memfd: Add write seals when apply SEAL_EXEC to executable memfd
Date:   Tue,  6 Dec 2022 15:23:56 +0000
Message-Id: <20221206152358.1966099-5-jeffxu@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
In-Reply-To: <20221206152358.1966099-1-jeffxu@google.com>
References: <20221206152358.1966099-1-jeffxu@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

From: Jeff Xu <jeffxu@chromium.org>

In order to avoid WX mappings, add F_SEAL_WRITE when apply
F_SEAL_EXEC to an executable memfd, so W^X from start.

This implys application need to fill the content of the memfd first,
after F_SEAL_EXEC is applied, application can no longer modify the
content of the memfd.

Typically, application seals the memfd right after writing to it.
For example:
1. memfd_create(MFD_EXEC).
2. write() code to the memfd.
3. fcntl(F_ADD_SEALS, F_SEAL_EXEC) to convert the memfd to W^X.
4. call exec() on the memfd.

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 mm/memfd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/memfd.c b/mm/memfd.c
index ec70675a7069..92f0a5765f7c 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -222,6 +222,12 @@ static int memfd_add_seals(struct file *file, unsigned int seals)
 		}
 	}
 
+	/*
+	 * SEAL_EXEC implys SEAL_WRITE, making W^X from the start.
+	 */
+	if (seals & F_SEAL_EXEC && inode->i_mode & 0111)
+		seals |= F_SEAL_SHRINK|F_SEAL_GROW|F_SEAL_WRITE|F_SEAL_FUTURE_WRITE;
+
 	*file_seals |= seals;
 	error = 0;
 
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

