Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5413EB64DC
	for <linux-hardening@archiver.kernel.org>; Wed, 14 Jun 2023 19:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236412AbjFNTYS (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 14 Jun 2023 15:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236349AbjFNTYR (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 14 Jun 2023 15:24:17 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339ED26A4
        for <linux-hardening@vger.kernel.org>; Wed, 14 Jun 2023 12:24:04 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6667defb5a3so499861b3a.3
        for <linux-hardening@vger.kernel.org>; Wed, 14 Jun 2023 12:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686770643; x=1689362643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JBFhzdyVFTFeidFRV/hzmSKzDZQEfLbMd1EOce0vowg=;
        b=PuyEFSGBXGTrO/fhnwBpCkobIO5Jk0/+9gDFSJqGsDrc1TEiSpswv2wUEiuqy9xEcz
         62U47wGFpFzCuFrREagC8eEbD2FxOcYrBcsQFjO62hqW5F+J1ZlWuUvYdhN5iR17064j
         JUercQ1Lpn//9ZJX+29k81+pv2OIEEUpTYMmw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686770643; x=1689362643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JBFhzdyVFTFeidFRV/hzmSKzDZQEfLbMd1EOce0vowg=;
        b=FKPPXTyBlbkGmIW6+y4LX5TNbBZeLAZcsgxJ7o0EfYW5t/Yi024uMoN4/6H2NBlrfN
         HWKPpUPfOthz18a3PF/+9ohdm+CuA08zp/vXWC+x01u1Dv3yZn5bfpbU9/+2B4WdFcQF
         wCSuocb4wQeBH0kRhN31MThB//qH5r2vJ9FDESusiwm1aGb9qlLZlRpmhwGsWalyBGAE
         zwVIrjMCtdwdBajqZISUU2J4LcN647peH5f7pH8kiyyGLfjvlyXCFdWo4n1KP9YYurKd
         B5aWfU/rfuL6o48jqj4iWyaEAluh6YyK8Ozmv81xBNZ1yWsl0qiqajANxW49y6lYE9SI
         axOw==
X-Gm-Message-State: AC+VfDyTQmizVLV9YIZ0axBFwp654GDCQ2gFHsmofMfzqNn5uFW/RQAq
        +L2ft3nXWaP0z+fShsi9aFYQDA==
X-Google-Smtp-Source: ACHHUZ7SPmlNngLf5Yjzik1pSrgKnOJsza4hMlfEDXZnlvtwsMUHrcep3YDul2Kfpc98729xaV417w==
X-Received: by 2002:a05:6a20:5481:b0:10c:b441:5bd0 with SMTP id i1-20020a056a20548100b0010cb4415bd0mr3078684pzk.18.1686770643711;
        Wed, 14 Jun 2023 12:24:03 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a17-20020a62e211000000b0063b6cccd5dfsm1619049pfi.195.2023.06.14.12.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 12:24:03 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     keescook@chromium.org, richard@nod.at
Cc:     linux-um@lists.infradead.org, linux-hardening@vger.kernel.org,
        anton.ivanov@cambridgegreys.com, Al Viro <viro@ftp.linux.org.uk>,
        johannes@sipsolutions.net, azeemshaikh38@gmail.com,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] um: Use HOST_DIR for mrproper
Date:   Wed, 14 Jun 2023 12:23:28 -0700
Message-Id: <168677060698.1965769.17288786387912659034.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230606222442.never.807-kees@kernel.org>
References: <20230606222442.never.807-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, 6 Jun 2023 15:24:45 -0700, Kees Cook wrote:
> When HEADER_ARCH was introduced, the MRPROPER_FILES (then MRPROPER_DIRS)
> list wasn't adjusted, leaving SUBARCH as part of the path argument.
> This resulted in the "mrproper" target not cleaning up arch/x86/... when
> SUBARCH was specified. Since HOST_DIR is arch/$(HEADER_ARCH), use it
> instead to get the correct path.
> 
> 
> [...]

Build tested with/with-out patch, and I can see "mrproper" target
correctly cleaning up now.

Applied to for-next/hardening, thanks!

[1/1] um: Use HOST_DIR for mrproper
      https://git.kernel.org/kees/c/48ad87a5be06

-- 
Kees Cook

