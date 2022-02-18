Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3EE3C433EF
	for <linux-hardening@archiver.kernel.org>; Fri, 18 Feb 2022 10:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbiBRKC2 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 18 Feb 2022 05:02:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233830AbiBRKC1 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 18 Feb 2022 05:02:27 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E62136338;
        Fri, 18 Feb 2022 02:02:10 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id 6C6711F4669A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645178529;
        bh=BRpG7lT73p8j/yPOX/VdUqsaERYF6RUrgfHeGmWO+qI=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=DtvW4EadOO/FFgVRMnvqmbeN3aGUgVnMjvhg1mvuq2U/JOGPwXrWebglTSWtAq5UH
         0Tt3+4uTLzynDU57k4zbUQrnistEVxxR+3MH1FWm2D4CkThaN122g43rFSDXf3Eh1p
         tkxXLWzxpgqQllnCpvJGPEWRohPGa9yxVoP4CEBVq2pYYA6/SR3YZYpWsUdAFnLAeQ
         9UjQ4y1Da16Wz5OKuw4qq4BDO+Rh5tLr97jXs4RufBm/EATa/64OqZYjX/0O9eLpVi
         NXe1SUqQ/hBJpBMlJY+cGU6Bc/Si66MURlco+Bye36l+WwsjUAlwqlvZEBq+ybCseB
         QXy7v9fE92klw==
Message-ID: <ed8f61c2-77be-016b-5187-3da4e0ca84e0@collabora.com>
Date:   Fri, 18 Feb 2022 15:02:02 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Cc:     usama.anjum@collabora.com, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] lkdtm/fortify: Swap memcpy() for strncpy()
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
References: <20220216202548.2093883-1-keescook@chromium.org>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20220216202548.2093883-1-keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 2/17/22 1:25 AM, Kees Cook wrote:
> The memcpy() runtime defenses are still not landed, so test with
> strncpy() for now.
> 
> Reported-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
