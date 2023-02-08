Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70611C636D3
	for <linux-hardening@archiver.kernel.org>; Wed,  8 Feb 2023 18:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbjBHS6d (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 8 Feb 2023 13:58:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbjBHS6c (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 8 Feb 2023 13:58:32 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C54C54541
        for <linux-hardening@vger.kernel.org>; Wed,  8 Feb 2023 10:58:31 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id d2so15645924pjd.5
        for <linux-hardening@vger.kernel.org>; Wed, 08 Feb 2023 10:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3dkVne6QOQuiWRjarawnc2yDR1hi271zLDnK3/8Voi0=;
        b=UVbJ9xsLJiIJd2F3wQr18Dc6vf1t1u0vmP2LeaC8EAJTD0YwmMSpbp2WHw1gHsoG/g
         QYPN0EFStY/TgncavC3gzVnLZ0j3eANngoaJgpPhsPwgsUrShOB2ys3OL70zo3NnZmXZ
         3X/VdPwZ/EQXItjYA62Vk5s5T/8eTlUE9hKnk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3dkVne6QOQuiWRjarawnc2yDR1hi271zLDnK3/8Voi0=;
        b=B+IU6pLZPTJunnMS4JutgVREvYR3+usMvDeICZN+C3ZPcu+JNN40UwVbqdHMEhe4K0
         tbpOypqHGqQct7qYxwg6KLo6WcfNBQj9F04EOPhAwYN4M7GRu4bA2eCYuSbJJB+2onAB
         wpwE28dH7iefVEEacSjiYn5REcoUxljMEtgn/F62oEZY4IvsATm1CwO5satq6mneZr/I
         Y7WLeUM2P+sTuFaRVC3wPtaQJvBiw+1jXGoTuDzk24L+hXGR0ifTSG5eh9pPruXJPtA/
         2xtcnP2qpeuiQnTw0PHwCXQu7TBouxyr16f++wOcShfe6YtyOS4OVh5c/DBe0Ty5c4rt
         qqhA==
X-Gm-Message-State: AO0yUKUIPtWGK1OslAGWrouDM2XZUvX0R1Qg5lzlCAKSHTggxw5MLfCg
        g+dgRZ3X1hW2wL2l0682mTByGA==
X-Google-Smtp-Source: AK7set+W13zod//i71uQI6lj/ZQHRIZUB6Bc0TJ8c+Ig+pIur65SH1HtUzuX+65B2W8SuYAFLnoWGQ==
X-Received: by 2002:a17:90b:384c:b0:22c:2d76:2713 with SMTP id nl12-20020a17090b384c00b0022c2d762713mr9884383pjb.32.1675882710714;
        Wed, 08 Feb 2023 10:58:30 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x3-20020a17090a1f8300b00230e733599esm1850623pja.48.2023.02.08.10.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 10:58:30 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     linux-hardening@vger.kernel.org, ebiggers@kernel.org
Cc:     Kees Cook <keescook@chromium.org>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        morbo@google.com
Subject: Re: [PATCH] randstruct: disable Clang 15 support
Date:   Wed,  8 Feb 2023 10:58:21 -0800
Message-Id: <167588270061.464935.14207013093507497315.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230208065133.220589-1-ebiggers@kernel.org>
References: <20230208065133.220589-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, 7 Feb 2023 22:51:33 -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> The randstruct support released in Clang 15 is unsafe to use due to a
> bug that can cause miscompilations: "-frandomize-layout-seed
> inconsistently randomizes all-function-pointers structs"
> (https://github.com/llvm/llvm-project/issues/60349).  It has been fixed
> on the Clang 16 release branch, so add a Clang version check.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] randstruct: disable Clang 15 support
      https://git.kernel.org/kees/c/7ee3819f2ba9

-- 
Kees Cook

