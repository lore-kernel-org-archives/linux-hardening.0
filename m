Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82EE2C433EF
	for <linux-hardening@archiver.kernel.org>; Mon, 31 Jan 2022 14:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235092AbiAaO1I (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 31 Jan 2022 09:27:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35123 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233565AbiAaO1H (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 31 Jan 2022 09:27:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643639226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XotDDQeMlhTz5unKcz9Redk8XXunizuT/0Oe6ZUsayQ=;
        b=L+wwEK/1fLtj67m5YqeapOTyrZRHBiALiv7x/1p2t2cKwbYhIzOsSEXGT6uSGiAeACWOlP
        bsts6ToXx/O5kAaofSD+fTVXyed3m/8583z6WC0bkCRzvKb0PLwmwkQd1g0TW+8ZfRss+y
        2F6OJ4aJrmr5UTsD41LQzPDXlpITGYM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-654-t8kwxIjZNmGjaqbC6arWvw-1; Mon, 31 Jan 2022 09:27:05 -0500
X-MC-Unique: t8kwxIjZNmGjaqbC6arWvw-1
Received: by mail-wm1-f70.google.com with SMTP id l16-20020a1c7910000000b0034e4206ecb7so5831882wme.7
        for <linux-hardening@vger.kernel.org>; Mon, 31 Jan 2022 06:27:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=XotDDQeMlhTz5unKcz9Redk8XXunizuT/0Oe6ZUsayQ=;
        b=HyCsrgkagBhvvb3bqAHREi3JtERKpkX0EpkNuZ2fZ1K9ARgjdylVovjyxuTqn6U/uR
         dVP2doyorwSk2OD70Rz8beKkxydaz98mFQ/wJEUEQ7ngHQWNLumIMOJwpfGhkD/ECdlR
         Ub9oW3wXfapv5TA0m1wwz3pnB6ORNtqbSG5qivoRjxi6TtVEeG3PjPrSGFwrlAFe5LoA
         R2rUYr7xL2GHm6W2/eLx5VOWehCbmZkwApXtxOK6K/PGdpB1TPTenZlsIY+6P5BrHUiu
         zYL6rZ4N6S2w7peZVhFS/jNvEK5cy1+osaogMOs4pSpdccYezERLRFhTSmnzUUZDkMQI
         2hLw==
X-Gm-Message-State: AOAM531yRziXC9yRtAOi8r6y1qOzGKvta7REGyEVnSQVQj84uKdFaL8h
        /vH0EXMVK0kcL0PSx/0XunyNbM4iJHcxQknXj6sm8kXRL+ytNriuOa20Z9byA3/qoJ0kvOEhwkg
        8r4GITBgpAhV3kZEHbXvlu81SdyU5
X-Received: by 2002:adf:da46:: with SMTP id r6mr17811711wrl.71.1643639224334;
        Mon, 31 Jan 2022 06:27:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwGhjD/linj4Vn3ALHc3LVkqeg6aXzW2W5KkJr0teagoNnaqzpRNVH01dvLGWWJHR+7qXTXPQ==
X-Received: by 2002:adf:da46:: with SMTP id r6mr17811692wrl.71.1643639224097;
        Mon, 31 Jan 2022 06:27:04 -0800 (PST)
Received: from ?IPV6:2003:cb:c709:b200:f007:5a26:32e7:8ef5? (p200300cbc709b200f0075a2632e78ef5.dip0.t-ipconnect.de. [2003:cb:c709:b200:f007:5a26:32e7:8ef5])
        by smtp.gmail.com with ESMTPSA id z3sm10170246wmp.42.2022.01.31.06.27.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jan 2022 06:27:03 -0800 (PST)
Message-ID: <2858cfa9-2329-6da9-82b8-643f29d548e6@redhat.com>
Date:   Mon, 31 Jan 2022 15:27:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 4/4] usercopy: Remove HARDENED_USERCOPY_PAGESPAN
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-mm@kvack.org, linux-hardening@vger.kernel.org
References: <20220110231530.665970-1-willy@infradead.org>
 <20220110231530.665970-5-willy@infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220110231530.665970-5-willy@infradead.org>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 11.01.22 00:15, Matthew Wilcox (Oracle) wrote:
> There isn't enough information to make this a useful check any more;
> the useful parts of it were moved in earlier patches, so remove this
> set of checks now.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>


Very nice cleanup IMHO

Reviewed-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb

