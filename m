Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D78C001B0
	for <linux-hardening@archiver.kernel.org>; Tue, 15 Aug 2023 23:45:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240686AbjHOXoh (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 15 Aug 2023 19:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240696AbjHOXoW (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 15 Aug 2023 19:44:22 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA0C113
        for <linux-hardening@vger.kernel.org>; Tue, 15 Aug 2023 16:44:21 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6887b3613e4so269258b3a.3
        for <linux-hardening@vger.kernel.org>; Tue, 15 Aug 2023 16:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692143061; x=1692747861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vG5YLVC3eDKirzY40GTGyFbIQV7NMpfOOW8qjICzL9g=;
        b=oBXtosF0pp2dlR76dRPteSznb7v90y3c6+QKAWDhL0B6LTQLODDst9tl3HBtqXjUA8
         EybyR9mmvR+KQNYPEAvYX8oupycUhhaQu1sCAeF4KwKh7OicB3Mo0FjopdJ0TG+2HhQb
         qyGQY2g3xsuvhVaqH+E/g9x60PXAhkkqYZIEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692143061; x=1692747861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vG5YLVC3eDKirzY40GTGyFbIQV7NMpfOOW8qjICzL9g=;
        b=CYC3gB0dVe9+D9oHGSdist9vKy3Byrrczhsl7Y/FZ4eBiuGHG2gTQ5Ld8GXdKn5aX/
         wn6bieGYp1Ius09u+6vXW0Xr46XzqrGcanYQqY3tRsFuRigGgulOxvQcKDd9ptfTFUc9
         TMEM2MkwfIMv/dn4YqRE8HxUoiGRzAK8XDrIFfKoOkxFaTPaVYmf8n2/goZ20/mCBCzF
         D6pKrxNktWR8gb3t0BeAxVbI7UA4pmeiiIk4lEv6BXt7xg15FbsQOyXzrKoNdIRVAIle
         rusTPUN2rW0x/7K19J3JOsa5KfaCt5V8ClkJlzXUKV8Q14iu4cqB2YcMgBHOK2S05oCI
         9owg==
X-Gm-Message-State: AOJu0YyE2ELOyBIeC3BbMmPZgExDxZtyzfsDzogWpK5tPHLYk7JP/XcM
        ohTePIXpOECQd8sk1rndae1/AA==
X-Google-Smtp-Source: AGHT+IG8Qw+6jUTPGs1F8o/6hKdeLl9A+ocEC7eGLPrbZ6ZXpvHBmVQO4M3yBWHEjJZizziKMOuRSA==
X-Received: by 2002:a05:6a21:61a:b0:12b:fe14:907e with SMTP id ll26-20020a056a21061a00b0012bfe14907emr378877pzb.20.1692143061097;
        Tue, 15 Aug 2023 16:44:21 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s11-20020aa78d4b000000b006878f50d071sm9735097pfe.203.2023.08.15.16.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 16:44:20 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] alpha: Replace one-element array with flexible-array member
Date:   Tue, 15 Aug 2023 16:44:12 -0700
Message-Id: <169214305098.657491.4672688597029199904.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZMpZZBShlLqyD3ax@work>
References: <ZMpZZBShlLqyD3ax@work>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, 02 Aug 2023 07:25:56 -0600, Gustavo A. R. Silva wrote:
> One-element and zero-length arrays are deprecated. So, replace
> one-element array in struct osf_dirent with flexible-array
> member.
> 
> This results in no differences in binary output.
> [...]

Applied to for-next/hardening, thanks!

[1/1] alpha: Replace one-element array with flexible-array member
      https://git.kernel.org/kees/c/967afdf808cf

Take care,

-- 
Kees Cook

