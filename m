Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC6CC41513
	for <linux-hardening@archiver.kernel.org>; Thu, 27 Jul 2023 15:53:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233776AbjG0PxD (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 27 Jul 2023 11:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233707AbjG0PxC (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 27 Jul 2023 11:53:02 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD8F9271D
        for <linux-hardening@vger.kernel.org>; Thu, 27 Jul 2023 08:53:00 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b8ad356fe4so6955225ad.2
        for <linux-hardening@vger.kernel.org>; Thu, 27 Jul 2023 08:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690473180; x=1691077980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tsln9vKd77VrKuSCt5b74Dm8nHR1wAeieAig4NB5efM=;
        b=nXJUOUbb//dCVbV2sNfuul/Inn6960O/kVZTCj/H6sx1GdOxxNK6slNWvKKjY+iP61
         GAzYNIFfZK77JXKjmzOAxURrTGpZE7SQkmwqETn1oPudri7QL5DTL3n2+JNk5OoH6rQa
         peDFusmEllNIHZfnhbZyCrIZtwkTDrKl0K/nQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690473180; x=1691077980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tsln9vKd77VrKuSCt5b74Dm8nHR1wAeieAig4NB5efM=;
        b=BLDVuOInb7oOx2WDsX5faGb3rG0GWaxYqpoKWG+kRZyQ1KQk5C0VvBqldo5GZriDaG
         yniBWmufPdPJ/HAYCHx8o25WYvleauZND1qzJIEbVSgdSHUOP3PaX5Oe0QtIBLz4FoXx
         tiw0gQsdsK0w/baKgMmJu+hLc2E5bYCom2LVnmeukXKAI/tmeYsyUgXlfZJzKJySdFgP
         chq0prVYYQyi3TN6Swsznu15O6UHMadj8iXV1rj/LNRTOk7OiXEeC3fNEybjx5aC/swk
         4kwS6pu89Hc9rgsdXC+GAxXdBbES/vri3bxZ93xpS/eAieGf9IPNR5Ee8FYXj49yBQLS
         dL2A==
X-Gm-Message-State: ABy/qLbcPH9maWuBUxllkcQKBBo7z2VhqH07rDZhydeNzVTKDbFLQ/SX
        OUf1AESwnMP/GRXbgLjq3eXbUg==
X-Google-Smtp-Source: APBJJlFOaM/OFa4DX6l2QCKWulPgwcxSJTXbEbkawxaDeRErqsLH0YJUo8GTRiLZLV6zU5t99voBfQ==
X-Received: by 2002:a17:903:24d:b0:1b8:9044:b8ae with SMTP id j13-20020a170903024d00b001b89044b8aemr4985631plh.11.1690473180185;
        Thu, 27 Jul 2023 08:53:00 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jl21-20020a170903135500b001bbab888ba0sm1803506plb.138.2023.07.27.08.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 08:52:59 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: Replace strlcpy with strscpy
Date:   Thu, 27 Jul 2023 08:52:53 -0700
Message-Id: <169047317156.2400214.7935379824991435172.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230703165817.2840457-1-azeemshaikh38@gmail.com>
References: <20230703165817.2840457-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org


On Mon, 03 Jul 2023 16:58:16 +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
> 
> [...]

Applied, thanks!

[1/1] perf: Replace strlcpy with strscpy
      https://git.kernel.org/kees/c/c9732f1461f9

Best regards,
-- 
Kees Cook

