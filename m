Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7328FC433EF
	for <linux-hardening@archiver.kernel.org>; Mon, 25 Oct 2021 07:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CC3060724
	for <linux-hardening@archiver.kernel.org>; Mon, 25 Oct 2021 07:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbhJYHV0 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 25 Oct 2021 03:21:26 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:47096 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbhJYHVX (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 25 Oct 2021 03:21:23 -0400
Received: by mail-wr1-f42.google.com with SMTP id k7so6351304wrd.13;
        Mon, 25 Oct 2021 00:19:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=ZnBp/o9Bi8EpF/7DBrrr3u6I6nvXZIMo7mpSFih6RFCxATcFwS3d6F3vnPewXOAoCs
         slDKPCzGcyWTCbhI0n6nDsq1enTUga37DwDm3rt/glKAzg43IxOmRoSFIl8YZ40GPsCz
         qWa8V56o9nmQE19qf2kUKl1PMEYP7Xg5jZFMcslChP/9q6WY/gqUtT+/GjKdtjrVy/pa
         JVrlCHh1lKSLeQLuEs0KbaYZS+RG99mmV7CwM/rh9qiOa6dIxIaJDjCPLIsNTtJUsZgf
         D44PqBPP3LVzs82b8O0Cd+SvlkW/6/JBdhod6XpZGnN3kwSSV3z0/mREOCrGLYz2iC/k
         2T1w==
X-Gm-Message-State: AOAM532lYDWhGCdvxbon69OedmG+4bqmC74kWrVJIsUS6dxaJs/muAcn
        2wQtpiRBq1joPtEY2OIDnQJ17Akn7t0=
X-Google-Smtp-Source: ABdhPJzjP670GgIe7+Bqx6nvJCFvZ3NrT2F+UvQIQBsO/uRySjF8DzeuZ1Ud/jOZTyzaM2ya21t60A==
X-Received: by 2002:a5d:6d51:: with SMTP id k17mr20926449wri.233.1635146340045;
        Mon, 25 Oct 2021 00:19:00 -0700 (PDT)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id c7sm12387886wrp.51.2021.10.25.00.18.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Oct 2021 00:18:59 -0700 (PDT)
Subject: Re: [PATCH] nvmet: prefer flex_array_size and struct_size over open
 coded arithmetic
To:     Len Baker <len.baker@gmx.com>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Chaitanya Kulkarni <kch@nvidia.com>
Cc:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20211024172921.4110-1-len.baker@gmx.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <c56b8f55-3fa8-0201-28ae-10a275319fef@grimberg.me>
Date:   Mon, 25 Oct 2021 10:18:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211024172921.4110-1-len.baker@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
