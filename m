Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95BD4C77B7E
	for <linux-hardening@archiver.kernel.org>; Thu,  1 Jun 2023 21:04:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbjFAVEd (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 1 Jun 2023 17:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjFAVEd (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 1 Jun 2023 17:04:33 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559F6192
        for <linux-hardening@vger.kernel.org>; Thu,  1 Jun 2023 14:04:31 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b04949e5baso11942035ad.0
        for <linux-hardening@vger.kernel.org>; Thu, 01 Jun 2023 14:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1685653471; x=1688245471;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K31mK0e+lIqylDP59GLpflc/FdALwYXOTEKBXYSCF3s=;
        b=hD86mUY+jh5Zr2r/OzEM0gXDwcMSCuP0E3Mpln2EzFR5snPWjqAabs2J0xyA8iQNOw
         eET4SphsWQLerVWdmiRSkShubeB+xEDyJ4I7qEFAIcvb8WOTtKPqyMlXNNeaocvXW2kH
         5ES/j4TYGlpedOet+dBKJol76pC/VtZwTdVZrvBZ/ItjXWGyt3gCOt/mEraErqqALmMl
         RfimiiKTwlH65pIWR9c2C63g5VezIf2prF0S5uWvoVWKnBgkoCvdqIFwXncSO6rckt0U
         lvn3r0wtzRID1YMpNeWoWmP5b2vJHcbgEMsB0MGFSfs2GLlJNEHJz1m5IoFHbxT1zUiS
         jpfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685653471; x=1688245471;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K31mK0e+lIqylDP59GLpflc/FdALwYXOTEKBXYSCF3s=;
        b=ONmerBuRwJjACef+Ua5LqblKnqOzJfU7LwE/9C1Lp9IyOYK189c22BE2CTaBsYTQOY
         auqLNK18XCrBMc3cyOIsQijilceDVet/zSP1q/mgoOZonKfyU/gnOtQYEEJRQZuh0b1R
         /SmvFRoQ/sYKIBVxPz/FuQAuxUwUMEPOvbYYog1OdVHfXFI9DhJLq4U+8RBJeseRIQOF
         4JNlhfBV+iZF+BWhIlfdyc+MOuhXtvop4IqP1hZFREIXWE4hsV8KCxurRULH6SnR5Jkm
         yTz/TCBDigE/+wSBxu7zQPtw5Iu27/xx9MGKkot28ZbsU7j8g05vibLF2G/+uXzSn9Ia
         N0tw==
X-Gm-Message-State: AC+VfDz0ezLcU71NSocUQMGizWDgJDv5eh3OLGXJnL+WO3tblgc5V59R
        9y/dBri5QxZuGvH5f0y4gCaYDA==
X-Google-Smtp-Source: ACHHUZ4tEOZ/E7aubo2t8nuiBBW7VMGKRiaRb2mGTccmObI2XGljcRJI09ojuq0f4iNB65iD0dXc8g==
X-Received: by 2002:a17:903:4292:b0:1b1:78ba:f350 with SMTP id ju18-20020a170903429200b001b178baf350mr456252plb.46.1685653470704;
        Thu, 01 Jun 2023 14:04:30 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id b7-20020a170902650700b001b034d2e71csm4009814plk.34.2023.06.01.14.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 14:04:30 -0700 (PDT)
Date:   Thu, 01 Jun 2023 14:04:30 -0700 (PDT)
X-Google-Original-Date: Thu, 01 Jun 2023 14:04:00 PDT (-0700)
Subject:     Re: [PATCH v2] riscv/purgatory: Do not use fortified string functions
In-Reply-To: <202306011331.880AF01743@keescook>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, ndesaulniers@google.com,
        linux-kernel@vger.kernel.org, gustavoars@kernel.org,
        linux@leemhuis.info, heiko.stuebner@vrull.eu,
        linux-hardening@vger.kernel.org, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, joanbrugueram@gmail.com,
        masahiroy@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
        ajones@ventanamicro.com, hi@alyssa.is
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     keescook@chromium.org
Message-ID: <mhng-cb8265a9-018d-483b-8de9-b7b2eaa5557f@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, 01 Jun 2023 13:31:33 PDT (-0700), keescook@chromium.org wrote:
> On Thu, Jun 01, 2023 at 01:17:03PM -0700, Palmer Dabbelt wrote:
>> On Thu, 01 Jun 2023 11:27:03 PDT (-0700), keescook@chromium.org wrote:
>> > On Thu, 1 Jun 2023 09:00:28 -0700, Kees Cook wrote:
>> > > With the addition of -fstrict-flex-arrays=3, struct sha256_state's
>> > > trailing array is no longer ignored by CONFIG_FORTIFY_SOURCE:
>> > >
>> > > struct sha256_state {
>> > >         u32 state[SHA256_DIGEST_SIZE / 4];
>> > >         u64 count;
>> > >         u8 buf[SHA256_BLOCK_SIZE];
>> > > };
>> > >
>> > > [...]
>> >
>> > Applied to for-next/hardening, thanks!
>> >
>> > [1/1] riscv/purgatory: Do not use fortified string functions
>> >       https://git.kernel.org/kees/c/ca2ca08f479d
>>
>> Sorry, I'd just applied this to riscv/fixes as well.  I can drop it if you
>> want?  I was going to send a PR tomorrow, just LMK.
>
> I'm fine either way. I was carrying each arch's fix just since it was
> related to the -fstrict-flex-arrays=3 patch in the hardening tree.

Works for me, I'll drop it.

Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

The bots will probably get confussed and it was briefly visible to 
linux-next, so there might be a bit of spam.
