Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB34225A32
	for <linux-hardening@vger.kernel.org>; Tue, 11 Mar 2025 10:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741687796; cv=none; b=u5debJzuQgfG4+NwWY6SwO4NJP+UQOYt+fJgnKqFWA+JYN+B6+7bGmqL973Z0F/ZW6Y5GRIbtu+XXg6NgkHjcjlfvDNDjYxIi/BrSBTdlQ5H+zDJgIva+n7VxHgpuhag+Zj31g7CeNh8eXYW/xFeHsr+MXCVOJodOINqZADYRo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741687796; c=relaxed/simple;
	bh=ZR+XCIBQs9+80ifRtPgR+U/OFpGq/zuM7lgT746lhxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R/amDoKbfdLxJCAdhUNGAJWaTSa5sL/tNMhGgSMVe03oh3L7rYj4mrHmlbH7Qb93G21RCNgrlc92MBvjj8Wy7uU4dbqQksNHvR2asA+rFAHMZa6C7Qo3muV3FFd+sPNA+X8P6kRLrNZkG3ct96+BIoUqLXSWBqj6min8IZP89mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YdXl6sEr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YdXl6sEr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741687793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IYjkd0g01QmPqFmmHmr74WTt10z1qqPixGBi+49Tezc=;
	b=YdXl6sErIZTVIsODFOvVsIDFfkCZqnc/69m6ymELiv8uO8mqy9Z5tqa35eRoKtUgrr7HfF
	KkiW/KWLN9DkKVggmQ8a31jFwuufLhmnR7Tv8Ry5zOEZz8yl1oQ8gBL+OSo/BvAWZ0CCht
	m8Fvv0CAO2oXn99W30N03ojWjnviUmE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-H9rbTHAzPomxh1J8URgfAw-1; Tue, 11 Mar 2025 06:09:52 -0400
X-MC-Unique: H9rbTHAzPomxh1J8URgfAw-1
X-Mimecast-MFC-AGG-ID: H9rbTHAzPomxh1J8URgfAw_1741687791
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ab39f65dc10so658148866b.1
        for <linux-hardening@vger.kernel.org>; Tue, 11 Mar 2025 03:09:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741687791; x=1742292591;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IYjkd0g01QmPqFmmHmr74WTt10z1qqPixGBi+49Tezc=;
        b=vCUK35vjID+8gVTnsZtwl6Bzq2XViYAMbJjxEmcR4fyBnprdZSp+c4m72pXiNb7YU0
         qdy1o0PJ7m08QNRiu0SpZSIuwX/A/LLUOufjx07V7xQpURtXW4UQTm5ckCBdiVcefJYt
         yuwg1952yrkEX+xNXcSMgpAO0tH5a42GK7AlVdPUIWMs82nKscQLfdRKds+sIriXQSK9
         w6Y4vq0XD2+JBn9X+88Y7P9BSYHAMAE8pQ6bQvooMWbFU5EgWnoxn2MntiSLkamXgszV
         hssOrAFStxnEejLO7lxG6rjvbCLIzhaL54UYqP0yae06k9Gxgzqh1t6jQTH5NbaPwz7d
         A5UQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOoqoBGqTTnK2HUCOlys8QPvOJL1V3I4Abceen0oUv6QH7kt9reZ9PEN70Z1jKHKezliegf0aZejVO6ebeS3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDkpzfWe32GwguQ9VBxGF98lW6qyEFtSM+U/ic9LLFoKwgrTlf
	JvpU7AH+bCNnSaaD1fFYUm0n2HgwvoelkNKiue8fBWkcMF35mH+0LAMNmVQMoe9dyPSFHEBZaYv
	jDUnoGaFktimVFXj5qLxKrhlCpqL0ciMdo8VeYxF2u1B1pEbE1nMTNOkWKTX7OAla6g==
X-Gm-Gg: ASbGncv//T0kyue+f2koHwGSP75n1yyZDuW1EcVOkliMci4A9nMhmTdwhzfDSKk3W3M
	8ZiutmH4+UCI2JzsebW6Wf0VieBV4awmXEV+0rLXTOehjeknEagb42SbY62fQpQ0KMJ3JwUGcI+
	CxVEBfv4il2Oq2NJgYIJv3UH/qG8VYF4zIYTo7lBq1eb1sggJ+2tAqwTsAoqluZ18WrtxyuUqPw
	Sv1HycIrXJNgb+DXYjpOMlqvhu/oQyKtzSUN2eSiyBaW6q9IziybSypqVg9U4pExE+MyQBKHbFA
	LxS05KqaOF0HY7A6YLIWDjIt2ELMmpWLdAjU7UKafKCnpIRytnzi+WzNyukDTQZyuLLuX4bCRjT
	38g6DkeQvtkbQHMdfoAg/VwgryvTx8ZkeGVEdX0Km0hut0rKil5F+6I/BSukvTk9W2g==
X-Received: by 2002:a17:907:720a:b0:ac1:e881:89aa with SMTP id a640c23a62f3a-ac2525b9c95mr2043899666b.5.1741687791354;
        Tue, 11 Mar 2025 03:09:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOtp2eumlycwdsPaAxaDUlofVKvmeDoy+4Ahh4afVHjwmszC51GixSB4O24V97bjopnGYZwg==
X-Received: by 2002:a17:907:720a:b0:ac1:e881:89aa with SMTP id a640c23a62f3a-ac2525b9c95mr2043896666b.5.1741687790943;
        Tue, 11 Mar 2025 03:09:50 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac288ffe157sm449727566b.132.2025.03.11.03.09.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 03:09:50 -0700 (PDT)
Message-ID: <7ceea724-4e9e-409e-88fa-0d186096744f@redhat.com>
Date: Tue, 11 Mar 2025 11:09:49 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vboxsf: Add __nonstring annotations for unterminated
 strings
To: Kees Cook <kees@kernel.org>
Cc: Brahmajit Das <brahmajit.xyz@gmail.com>,
 Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20250310222530.work.374-kees@kernel.org>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20250310222530.work.374-kees@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PZy7Jq6cZ8UHYNbq4SgcJRp6-RCI7ciDPFBzixlAqvw_1741687791
X-Mimecast-Originator: redhat.com
Content-Language: en-US, nl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 10-Mar-25 11:25 PM, Kees Cook wrote:
> When a character array without a terminating NUL character has a static
> initializer, GCC 15's -Wunterminated-string-initialization will only
> warn if the array lacks the "nonstring" attribute[1]. Mark the arrays
> with __nonstring to and correctly identify the char array as "not a C
> string" and thereby eliminate the warning.
> 
> This effectively reverts the change in 4e7487245abc ("vboxsf: fix building
> with GCC 15"), to add the annotation that has other uses (i.e. warning
> if the string is ever used with C string APIs).
> 
> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=117178 [1]
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Brahmajit Das <brahmajit.xyz@gmail.com>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: linux-fsdevel@vger.kernel.org
> Signed-off-by: Kees Cook <kees@kernel.org>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  fs/vboxsf/super.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/vboxsf/super.c b/fs/vboxsf/super.c
> index 1d94bb784108..0bc96ab6580b 100644
> --- a/fs/vboxsf/super.c
> +++ b/fs/vboxsf/super.c
> @@ -21,8 +21,7 @@
>  
>  #define VBOXSF_SUPER_MAGIC 0x786f4256 /* 'VBox' little endian */
>  
> -static const unsigned char VBSF_MOUNT_SIGNATURE[4] = { '\000', '\377', '\376',
> -						       '\375' };
> +static const unsigned char VBSF_MOUNT_SIGNATURE[4] __nonstring = "\000\377\376\375";
>  
>  static int follow_symlinks;
>  module_param(follow_symlinks, int, 0444);

