Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D57EEB64D9
	for <linux-hardening@archiver.kernel.org>; Fri,  7 Jul 2023 20:57:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjGGU5h (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 7 Jul 2023 16:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGGU5h (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 7 Jul 2023 16:57:37 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698602127
        for <linux-hardening@vger.kernel.org>; Fri,  7 Jul 2023 13:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6EmAQN8q5hYhEO3ayCEwrNvINTEM/qm89qIj7Pkbmf8=; b=RHyMtGutU4VJn6MRXXv+9opqz5
        gST7RCaPWq41ssdwgSkYEb7419N4rycwsiHJERjQnSOzTLlfYQt3VIw+syzWuHZ3Lmnuq+y07n52h
        T5DSbNW+FCON91PSmkqbx9Om9KV61662947zCJj3jKafH/GwlAdSaf1ZOp+pDA+54Hw+8kY3RMCGy
        BUzR+FSWDYYCtjQhsT0kpEMYsQQD8i124GqCRU9rMlUb+5nD2pzLZKxjo8jefAJ9EMcIRPoaZIVcI
        vh7a4z9e8KzfCVfpI8/t1T5ODJZ2lL3WcaYoRYLbAZytnyjlVz41x3mxJU0Gk5diMoW8NDKrCvsFt
        lkPzSZ6Q==;
Received: from [191.205.188.225] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1qHsWE-00AMLs-8U; Fri, 07 Jul 2023 22:57:34 +0200
Message-ID: <b610a5a3-5ae7-ae33-5501-b6748c1ac1ad@igalia.com>
Date:   Fri, 7 Jul 2023 17:57:29 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/2] pstore: Remove worst-case compression size logic
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>, linux-hardening@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Eric Biggers <ebiggers@kernel.org>
References: <20230707083456.2501913-1-ardb@kernel.org>
 <20230707083456.2501913-2-ardb@kernel.org>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20230707083456.2501913-2-ardb@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 07/07/2023 05:34, Ard Biesheuvel wrote:
> From: Kees Cook <keescook@chromium.org>
> [...] 
> 
> Co-developed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> [...]


Out of curiosity, why Kees is author but at the same time, he is a
co-developer? heh

Maybe it was Ard as either author or co-developer?
Cheers,


Guilherme
