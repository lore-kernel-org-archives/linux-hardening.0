Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E432CC77B6F
	for <linux-hardening@archiver.kernel.org>; Thu, 13 Apr 2023 22:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjDMWcQ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 13 Apr 2023 18:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbjDMWcH (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 13 Apr 2023 18:32:07 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F719B452
        for <linux-hardening@vger.kernel.org>; Thu, 13 Apr 2023 15:31:52 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id sg7so52521790ejc.9
        for <linux-hardening@vger.kernel.org>; Thu, 13 Apr 2023 15:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681425100; x=1684017100;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YQDbIwFVtmiyThnTsXLO/ibGRAKhipipij3kbIczsDE=;
        b=DDIbpvOias/ZOW/DHkYO7wwVvcCl4zMAoAcDQZ4cID1hIYPSLsnzVfd0rK87he5CTl
         HQ6L6VEzo3ntWKKEHtPSxHPAjQeN+TmQjf1cEwDR/mif6EEtFEg5z7MQZ7lDfaaGQ9XT
         RMqd4tc19BFbHLSL7oKevO4YoFUy8+1N+ngw2vFgTzb29l4zuiLPBJe9GGi5LP/4xxE5
         jhweYrw33hpHjrsXeDvNoJWJlhIiXYS9np/TWXrBCbuv9clzleJKr/+MFdA8dPFoMN6z
         ErwOD8hv8+MzleFlNzBG9YNUf8pN0v6o+kdLXxrHWGg3YKTg4TOVZZJ5zn+IKP9YES8i
         8u+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681425100; x=1684017100;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YQDbIwFVtmiyThnTsXLO/ibGRAKhipipij3kbIczsDE=;
        b=dpdXBh9daoURlqsG2qS5aQXQI8WqVi0i1XCSKtoEvFUa3FsDQRwBxUkN3ctYS70w0F
         XuvCy7fCHFdpzatEyQqHY9bVgnIfOjj6MefF973VD+fYvu8zrEXV+BSBHMcE9R93NWZA
         KdPVLqEeF+DRYY8Ee/BfoTT+04c09ZqulxmotmCKLOvYNCDSS8OcnEYiPbpZ0cfZzCjO
         882RKNLitMPsvpRya/cJZKIjDNls/6jop6xRAHbaOEzlyu59MYbyXAoDNhe14uTs6cuA
         ecejH2QVzFyk/wmF8jtigsxkOwmn3/gbhHbamZVzui+iWEaGoHeMeXAMnMGA8Tw7zl0j
         AIrQ==
X-Gm-Message-State: AAQBX9dH/pYsoGGb36LuHnul0Zcb9ytbWUyDhgjBaE+i058MicYhVVXR
        N6j37yTC5MVWTZ4KJWlb1vzhtQ==
X-Google-Smtp-Source: AKy350ZySqhlh9zeD7X2C5d/0Y/o1n0TdgBYLmvFVr61PjX/k6iD5j6cbSlZzv/3sj633kUoD7hXZw==
X-Received: by 2002:a17:906:84c:b0:935:535:42a7 with SMTP id f12-20020a170906084c00b00935053542a7mr4095374ejd.51.1681425100485;
        Thu, 13 Apr 2023 15:31:40 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id wv13-20020a170907080d00b0094ee21fe943sm28212ejb.116.2023.04.13.15.31.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 15:31:39 -0700 (PDT)
Message-ID: <24ec8534-60a4-b308-0831-9ab6b983d902@linaro.org>
Date:   Thu, 13 Apr 2023 23:31:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 3/6] docs: qcom: Add qualcomm minidump guide
Content-Language: en-US
To:     Mukesh Ojha <quic_mojha@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, corbet@lwn.net,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org
References: <1679491817-2498-1-git-send-email-quic_mojha@quicinc.com>
 <1679491817-2498-4-git-send-email-quic_mojha@quicinc.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <1679491817-2498-4-git-send-email-quic_mojha@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org



On 22/03/2023 13:30, Mukesh Ojha wrote:
> +Dump collection
> +---------------
> +
> +The solution supports extracting the minidump produced either over USB or
> +stored to an attached storage device.
> +
> +By default, dumps are downloaded via USB to the attached x86_64 machine
> +running PCAT (Qualcomm tool) software. Upon download, we will see

Are these both PCAT and dexter tools public?

--srini
> +a set of binary blobs starts with name md_* in PCAT configured directory
> +in x86_64 machine, so for above example from the client it will be
> +md_REGION_A.BIN. This binary blob depends on region content to determine
> +whether it needs external parser support to get the content of the region,
> +so for simple plain ASCII text we don't need any parsing and the content
> +can be seen just opening the binary file.
> +
> +To collect the dump to attached storage type, one need to write appropriate
> +value to IMEM register, in that case dumps are collected in rawdump
> +partition on the target device itself.
> +
> +One need to read the entire rawdump partition and pull out content to
> +save it onto the attached x86_64 machine over USB. Later, this rawdump
> +can be pass it to another tool dexter.exe(Qualcomm tool) which converts
> +this into the similar binary blobs which we have got it when download type
> +was set to USB i.e a set of registered region as blobs and their name
> +starts with md_*.
> -- 2.7.4
