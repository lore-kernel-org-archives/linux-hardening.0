Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 254CCC77B7A
	for <linux-hardening@archiver.kernel.org>; Thu,  1 Jun 2023 16:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbjFAQ6X (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 1 Jun 2023 12:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbjFAQ6V (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 1 Jun 2023 12:58:21 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6554C10CE
        for <linux-hardening@vger.kernel.org>; Thu,  1 Jun 2023 09:57:54 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-33d07bf83fcso3841925ab.0
        for <linux-hardening@vger.kernel.org>; Thu, 01 Jun 2023 09:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685638673; x=1688230673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HrJa2npduVqPVBdceO1uTgmstERDSfC0tCDcUBY0Kok=;
        b=Evy09YWIDeiRfZ7iWYo4Nfvi6VdHZvCiX00d75eU3bHNnDMH1PP4/Le5ci7VflkSpd
         JmjLBbFFoOTgBGm0i9nAEib42qojFCuLafQoTMTEjS22TERBI0gUSPvlM4nDSN+i5O84
         /8ytsl3rR/Dcrt4qmQkZEo4/5TtCJvuUJCTBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685638673; x=1688230673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HrJa2npduVqPVBdceO1uTgmstERDSfC0tCDcUBY0Kok=;
        b=XtmuSDFMYhXpThXGA+SidYMkDq8i5p+T1Tb58NG2YWQbuO4LHHY0r4yNiCqemOoE9Q
         FCo7ajUliR3832azfsR9PNtf8RRdkaeN+4Nabga4POBMtb4syFrQHg7wuePujroFzowB
         SrzzCn94wNVWBgqjOB/2X6pLodZFCyL33eSpvTIxGoMEvn25feZs6a+lLXW/Sx8+otUk
         t60DBjr99z1QN1gsP6YTtemPPUEQZSdLUeHoy5PU+Hhbv76MLEnS+Ojms4fgUBIg1+Xv
         ZSOQaKtkY4h7BsXU9xctqe3PkviswqXNxVHCgvExN04Hm7Pt4aH0HdTSjUMcYCdoA01y
         hIaQ==
X-Gm-Message-State: AC+VfDxWHbZORx7d4aQN1Q4ytDmmHdiwNoSeUo0NEKOkAoWc55Cjvhlr
        rBobLHIdbQkehN9fwJeSqa5OVw==
X-Google-Smtp-Source: ACHHUZ4hwXSPHpaOvMjXUKwc5pWw16c3LCA696AbxPK9XvyN3cD9LQtitn/2zLDIsSA3xgYtFkSMQg==
X-Received: by 2002:a92:cc01:0:b0:33a:5ec7:e07f with SMTP id s1-20020a92cc01000000b0033a5ec7e07fmr6184222ilp.5.1685638673689;
        Thu, 01 Jun 2023 09:57:53 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x11-20020a63cc0b000000b0053f2037d639sm3394389pgf.81.2023.06.01.09.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 09:57:53 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     tglx@linutronix.de, keescook@chromium.org
Cc:     masahiroy@kernel.org, mingo@redhat.com, joanbrugueram@gmail.com,
        peterz@infradead.org, hi@alyssa.is, glider@google.com,
        dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux@leemhuis.info,
        samitolvanen@google.com, hpa@zytor.com, ndesaulniers@google.com,
        bp@alien8.de, gustavoars@kernel.org, x86@kernel.org
Subject: Re: [PATCH] x86/purgatory: Do not use fortified string functions
Date:   Thu,  1 Jun 2023 09:57:49 -0700
Message-Id: <168563866754.2890079.16297092272263772482.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230531003345.never.325-kees@kernel.org>
References: <20230531003345.never.325-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, 30 May 2023 17:33:48 -0700, Kees Cook wrote:
> With the addition of -fstrict-flex-arrays=3, struct sha256_state's
> trailing array is no longer ignored by CONFIG_FORTIFY_SOURCE:
> 
> struct sha256_state {
>         u32 state[SHA256_DIGEST_SIZE / 4];
>         u64 count;
>         u8 buf[SHA256_BLOCK_SIZE];
> };
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] x86/purgatory: Do not use fortified string functions
      https://git.kernel.org/kees/c/f6ab7fc96a53

-- 
Kees Cook

