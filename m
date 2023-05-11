Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74505C77B7F
	for <linux-hardening@archiver.kernel.org>; Thu, 11 May 2023 08:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234709AbjEKIXU (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 11 May 2023 04:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjEKIXT (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 11 May 2023 04:23:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95002D59
        for <linux-hardening@vger.kernel.org>; Thu, 11 May 2023 01:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683793349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gk+R+YkjF963S2SpF4BsdMdE47AkKmd4xwPaX4Oi4+k=;
        b=jRWL/k4f5CslsaWj22QP6Rsh4zJ2YmKgfCShbyOo4iWEWo4jyKyXQ4h7n/6ZXL/ChDAbkb
        FcWHXs0QQrpSt8mSDXrj88zBYtGW8LST7vWJlxfadbuseABqTs1IbrdD1hYrSynBo22aGC
        8yO5Xrg/4tSD6J7mtLiu79+D5GSDvkc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-278-9xD8LOKGPjqs5TwDpD_qRw-1; Thu, 11 May 2023 04:22:27 -0400
X-MC-Unique: 9xD8LOKGPjqs5TwDpD_qRw-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-50bcd245040so9672202a12.0
        for <linux-hardening@vger.kernel.org>; Thu, 11 May 2023 01:22:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683793347; x=1686385347;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gk+R+YkjF963S2SpF4BsdMdE47AkKmd4xwPaX4Oi4+k=;
        b=VFihgjCmM1+JOFUmcYg2+U7GqNDhX9VjHQglm6BtcRb/4QPKHSOfEHg9GRSBmW+VSc
         W96jN3G8YGcpWPMJG9RqP27FNB4kAaQqV2g5EO9aLglasblZvBMeFYd5fmJdhcMXcYXN
         FS7S5yELVK2G1f6eOO+kYfiqO5jhJhc50L9XayriD1aq6vRsQW+N6mM/AkljCVqVLnc+
         ZLwo37WcpYIDJHTt4+jd/NH6TaHJI2cZQiskVHopciBCJoYuWRMu1A12Xn8zDbepiDWZ
         /ppArVUwKC3FRO+3NcTmU4tN7GMraZmJ7L+7indaOC08UcBLdFCD8PjCkw7LNBX/dC47
         IpnA==
X-Gm-Message-State: AC+VfDyGQKrS4+pflrp+tDdcKgqM3B/8/ZU1bnsATAPeaZfPIkSU3Jia
        l/1gdszUEcJG5ZVTkh1svZAidhantM10wwcbILZ6sEWhjFsiTipmmoCWnkTGF0f9Chn+c0ClwaA
        KNeqydHpJDogaP92lDtC9V/YAYo9K
X-Received: by 2002:a17:906:478f:b0:96a:3b67:40bb with SMTP id cw15-20020a170906478f00b0096a3b6740bbmr4004892ejc.40.1683793346900;
        Thu, 11 May 2023 01:22:26 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6zc4nyULHOnur3f+oxT8ygqFitbgjgoYUQJ4s85VdQCqWOCPEtYkKW/BM86bhB+vNheUGeNg==
X-Received: by 2002:a17:906:478f:b0:96a:3b67:40bb with SMTP id cw15-20020a170906478f00b0096a3b6740bbmr4004876ejc.40.1683793346524;
        Thu, 11 May 2023 01:22:26 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id s25-20020a170906285900b0096a5d341b50sm582560ejc.111.2023.05.11.01.22.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 May 2023 01:22:26 -0700 (PDT)
Message-ID: <7b406485-83dd-f3d9-4e82-6ca42d2f4b5a@redhat.com>
Date:   Thu, 11 May 2023 10:22:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] vboxsf: Replace all non-returning strlcpy with strscpy
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     linux-hardening@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230510211146.3486600-1-azeemshaikh38@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230510211146.3486600-1-azeemshaikh38@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US, nl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi,

On 5/10/23 23:11, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  fs/vboxsf/super.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/vboxsf/super.c b/fs/vboxsf/super.c
> index d2f6df69f611..1fb8f4df60cb 100644
> --- a/fs/vboxsf/super.c
> +++ b/fs/vboxsf/super.c
> @@ -176,7 +176,7 @@ static int vboxsf_fill_super(struct super_block *sb, struct fs_context *fc)
>  	}
>  	folder_name->size = size;
>  	folder_name->length = size - 1;
> -	strlcpy(folder_name->string.utf8, fc->source, size);
> +	strscpy(folder_name->string.utf8, fc->source, size);
>  	err = vboxsf_map_folder(folder_name, &sbi->root);
>  	kfree(folder_name);
>  	if (err) {

