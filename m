Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50395C77B7C
	for <linux-hardening@archiver.kernel.org>; Sat, 13 May 2023 09:13:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237144AbjEMJN1 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 13 May 2023 05:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjEMJN0 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 13 May 2023 05:13:26 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCDB12D57
        for <linux-hardening@vger.kernel.org>; Sat, 13 May 2023 02:13:24 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-965d2749e2eso1610307366b.1
        for <linux-hardening@vger.kernel.org>; Sat, 13 May 2023 02:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683969203; x=1686561203;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SXTHGE0Wl3MaP4uQCGWbuj/wOoT4T39v9HX0v0hxJf8=;
        b=C44D9GW14rmvbs7slqJlRtWSEfFd9m39+QRGn2224B3WZhCy2QWUpTUK/lBtbqxYIC
         iUZQ60xpLSaDuao6yvw1CKoebvNp5k0jXXOp31Cs/rcab+fomOK7Dk6edkGti7pS6h+U
         rMh8qN+jlW0Z9aHfGw0ktcUVqK6KcDablHWy99+cx3sDFD5Z1s1T65/72xMgqVojPav0
         lTahVG0K+dus6WDboiXKl0DVjo1Z9ClI2zt5MtjQNUtg5p7hRSVHulltwjriTq38DGNf
         FIRLNAwqnCRlpjEFLRCHqORBLnDV/PpYOQ1XptPRFE2BB+waXZUF/XUb3ew1gETvNgyn
         7EXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683969203; x=1686561203;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SXTHGE0Wl3MaP4uQCGWbuj/wOoT4T39v9HX0v0hxJf8=;
        b=PnHeY/3hay60fVZOkTrhjDwiP88Ip0J3zzCLch6TyEpFKS3SP704TsycXw1rUfnfOI
         9u7keY6WBuqx9IULhVccwWdri1VL3if6SyCQpqQrFDslMVf40/QmnaK4DDWPb9zsxLOA
         Ka/oUpTefHRK9t7xsqv58cjA6RYrEs+Mz1m4yZXMyphjsKmSZ/XJQ5aIft5PGnLlexqp
         pFlUjKv1WEcXAVlRso65iDKpmUDJP6geUnV6kxq9KK27pAgBoY+sDH4ddwCtt7yOq0vj
         LmdAbPF36BrfKcBGn+s3MKZUqiKFhPpW5iOFZuaEb9LuOJu6Pylc55rK4KLaZXwOiCgg
         kNBg==
X-Gm-Message-State: AC+VfDyBNnn+JAeEj+uktVrDI1+8hA7kM1/UM+81/13fC87QGXJcOR+e
        qcjPkrMukmx+y9u73p0HGnxdLw==
X-Google-Smtp-Source: ACHHUZ7jtwC+5aOEbgSa4I23nZNu1ofmb71WzoHsdxR68vtuGufCicwFl3Sq/PA8VrfW+/qE2RKTQw==
X-Received: by 2002:a17:907:9608:b0:969:e95e:e4f3 with SMTP id gb8-20020a170907960800b00969e95ee4f3mr17483776ejc.55.1683969203257;
        Sat, 13 May 2023 02:13:23 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:1d0:810a:586c:c5ba? ([2a02:810d:15c0:828:1d0:810a:586c:c5ba])
        by smtp.gmail.com with ESMTPSA id ib10-20020a1709072c6a00b009531d9efcc4sm6538708ejc.133.2023.05.13.02.13.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 May 2023 02:13:22 -0700 (PDT)
Message-ID: <65cf0de4-42b9-2b25-ac16-9e2ddfcfdb93@linaro.org>
Date:   Sat, 13 May 2023 11:13:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] docs: submitting-patches: Discuss interleaved replies
To:     Kees Cook <keescook@chromium.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     Thorsten Leemhuis <linux@leemhuis.info>,
        Rong Tao <rtoax@foxmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Zhangfei Gao <zhangfei.gao@foxmail.com>,
        linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tyler Hicks <code@tyhicks.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jiri Kosina <jikos@kernel.org>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Xujun Leng <lengxujun2007@126.com>,
        linux-kernel@vger.kernel.org
References: <20230511184131.gonna.399-kees@kernel.org>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230511184131.gonna.399-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 11/05/2023 20:41, Kees Cook wrote:
> Top-posting has been strongly discouraged in Linux development, but this
> was actually not written anywhere in the common documentation about
> sending patches and replying to reviews. Add a section about trimming
> and interleaved replies.
> 
> Cc: Jonathan Corbet <corbet@lwn.net>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

