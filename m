Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A74AC77B7F
	for <linux-hardening@archiver.kernel.org>; Fri,  5 May 2023 06:53:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbjEEGx5 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 5 May 2023 02:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbjEEGx4 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 5 May 2023 02:53:56 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08ACAD12
        for <linux-hardening@vger.kernel.org>; Thu,  4 May 2023 23:53:54 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-50bd2d7ba74so24053266a12.1
        for <linux-hardening@vger.kernel.org>; Thu, 04 May 2023 23:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683269633; x=1685861633;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+5tc2CyrPtqMpDuXO00/MEGgQ9p3JI0/atSwH0Ii1mY=;
        b=w5NUw1a9vT8f0AVOKaTDDu6iYddqpj4bW5s251lUBSYX0xwz3tQebHE9RVNtvO3o95
         nnRLrSrpEZueODRnRVeCikGOwGTrZq6hmQrZllewwy5Qqr0G3ZMx4ZicmIbokYxd+Cjr
         8E0LCjkQe50iaoZF+eYBwZ1TOJlhqvBGhYnSRPnN86813MDq2Me5sosx8/1ncNMi3vVc
         84HpsgjXENlH06t6QEeUdLZNFgcrx1CHhAnVLD9Ke6va7RKCLH3t6sTYoAJo6MLb77ib
         1iSwWmbHRJtxm06y+ir4f6KriWJVcpbNe5qaIWfvZp4f3fQ4LRFywsryKPK3rGawa2X4
         cygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683269633; x=1685861633;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+5tc2CyrPtqMpDuXO00/MEGgQ9p3JI0/atSwH0Ii1mY=;
        b=SOV1oiXioDUGK9FXh89GzTYXYf1kwCMQAgreVe9DlgavCkuOS9XH2IW7v9i+nhMFsE
         pnXkin9su4i53ovQZG3kSSW1ZgWMbpaM/bapWidznvApef+5jQZcL9fmrtocBFMCluOV
         pA8ua31mP/y9ZnXV+qtbE0fcwdjBBBerE0IHGdl0teyoOAQjM7UT+a1atRHXSWEP5V8G
         YEdJceyZaHmkf7ESwDAGu1SEWAXXpkWV1MIo+1p5HLc1eTpd9ymAznnnRwe7RY/QQEaA
         UpdXJBxUKbiG/TOVHoTbb85FOO1gpqpEInx6pkEPBmmuH805ifQjJ8y+edXqvkBQ5WS5
         oLNg==
X-Gm-Message-State: AC+VfDwxFV7TbPDyYxVYYeWKHyX8VDvOPY2EfC/KYJG4eHFXgz8YP5e/
        ytTr8WedD5JlGTf//p+jF0RMb6nDANIA789Fvi2szA==
X-Google-Smtp-Source: ACHHUZ4UqTMQclZve3W4bSXtxfuaOdUxuYDVJw+A56diQl+f74F0uraVpO1/McZ1VnsWYk6zNejEHw==
X-Received: by 2002:a17:907:9306:b0:932:f88c:c2ff with SMTP id bu6-20020a170907930600b00932f88cc2ffmr1125923ejc.34.1683269633268;
        Thu, 04 May 2023 23:53:53 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:52e:24ce:bbc1:127d? ([2a02:810d:15c0:828:52e:24ce:bbc1:127d])
        by smtp.gmail.com with ESMTPSA id n26-20020a17090673da00b0094eeea5c649sm554617ejl.114.2023.05.04.23.53.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 23:53:52 -0700 (PDT)
Message-ID: <63657ebd-41f8-69c7-5c4c-d77456d50d9f@linaro.org>
Date:   Fri, 5 May 2023 08:53:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 1/2] dt-bindings: arm: ti: Add bindings for PHYTEC AM62x
 based hardware
Content-Language: en-US
To:     Wadim Egorov <w.egorov@phytec.de>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-hardening@vger.kernel.org
Cc:     upstream@lists.phytec.de, nm@ti.com, vigneshr@ti.com,
        kristo@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, keescook@chromium.org,
        tony.luck@intel.com, gpiccoli@igalia.com
References: <20230504140143.1425951-1-w.egorov@phytec.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230504140143.1425951-1-w.egorov@phytec.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 04/05/2023 16:01, Wadim Egorov wrote:
> Add devicetree bindings for AM62x based phyCORE-AM62 SoM
> and phyBOARD-Lyra RDK.

If there is going to be new version:
Subject: drop second/last, redundant "bindings". The "dt-bindings"
prefix is already stating that these are bindings.

> 
> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof

