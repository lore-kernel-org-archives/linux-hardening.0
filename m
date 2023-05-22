Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA5EC77B75
	for <linux-hardening@archiver.kernel.org>; Mon, 22 May 2023 19:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235125AbjEVTkK (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 22 May 2023 15:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235164AbjEVTj7 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 22 May 2023 15:39:59 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41169CA
        for <linux-hardening@vger.kernel.org>; Mon, 22 May 2023 12:39:52 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-2537a79b9acso2831408a91.3
        for <linux-hardening@vger.kernel.org>; Mon, 22 May 2023 12:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684784391; x=1687376391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K2jEpAMn2sppJym9VTffGg66OqE+Owax2jsJobO+lpY=;
        b=GAhvMxLqlktEQWQhaTQzC0fI6WX0lWg5TOpNgoOFjFdrLDlZG5E7GmIAA1rSQCa89S
         vmhBNcre+8RDeFRCKiHq1mCkFwBYk1iukc1MhHJW0yHfX4mFq8sQAWmM2tgF+IOtfmMF
         BmcQ66ZNJNBl+QANYvaC5Vw6XN12vK60wnrpA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684784391; x=1687376391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K2jEpAMn2sppJym9VTffGg66OqE+Owax2jsJobO+lpY=;
        b=Rjg1DCT8/7AzjTFHMh9pbvg4dfSEL0pT9sWNsIeBk7Ti5yvUfvItaT8XCVsjZ5u3f7
         gAIy+9nvqC0kAHGKA0HQrxt6ms+JGMAkscVjsQbRo6mjkEuFPS6fMbgSfRfjIvo799n7
         XRCQKkhzPAR4JKR/sCVgjKGG0FT6wcfjREOOWCnC8Y9Qd4IFw6z+s7xMqgt2V7RW52I1
         DBbRg3nBXe2qvTabwsmpjomwEwZOvXDzWqk9VdaTG5Ly9j2yXthHXDJivGYIoqFEoOCq
         rWslH8AODWfVrZ7iHfBfl9EisSisEDNR6Llwz1QFoyMbJJrpKVFUfZoLN85X4ZFGA1GD
         MqEA==
X-Gm-Message-State: AC+VfDzjxuDPqeNlkNvzxPiyLM3pT6KF5UWYDSTleQ8BXr2LWhibN02r
        BQvbK7iA71NwXQUWgMHmPncfAg==
X-Google-Smtp-Source: ACHHUZ7XfU8otOHEaRosJGVI4waVEHdxQa79hW26NIgI5Mt2wGy/s+FrfhQZE3HBm0GnospWfH/K6w==
X-Received: by 2002:a17:902:e80e:b0:1af:a058:cc2d with SMTP id u14-20020a170902e80e00b001afa058cc2dmr7655903plg.57.1684784391659;
        Mon, 22 May 2023 12:39:51 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i1-20020a17090332c100b001a94a497b50sm5227419plr.20.2023.05.22.12.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 12:39:49 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     njavali@marvell.com, mrangankar@marvell.com,
        GR-QLogic-Storage-Upstream@marvell.com, azeemshaikh38@gmail.com
Cc:     Kees Cook <keescook@chromium.org>, linux-scsi@vger.kernel.org,
        martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        jejb@linux.ibm.com, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] scsi: qedi: Replace all non-returning strlcpy with strscpy
Date:   Mon, 22 May 2023 12:39:41 -0700
Message-Id: <168478437625.244538.15778765475911379516.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230517143509.1520387-1-azeemshaikh38@gmail.com>
References: <20230517143509.1520387-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, 17 May 2023 14:35:09 +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] scsi: qedi: Replace all non-returning strlcpy with strscpy
      https://git.kernel.org/kees/c/66f7f4013aa9

-- 
Kees Cook

