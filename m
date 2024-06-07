Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CC4194A45
	for <linux-hardening@vger.kernel.org>; Fri,  7 Jun 2024 12:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717763313; cv=none; b=cqjVHwJkWI4Q8cpBxxr84zwJ63gUNFfu4eZTx/fhKS6QUsjnaxprwCxd84FjYuoYVV7tYh4iS83tvxvQpSpxJYiY4DZT7zyVHI/OzKeecpc7RoW/YW30bdqj+qnUuWvUdkGoVJOru2K+Na2vHiFwyQHNrPzn3igREDS7SdQLTZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717763313; c=relaxed/simple;
	bh=jtFMpYBXTKwIn9TmGLRQUSYPmImRTFr8n8rOPMFw55A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=iOTfe3NHbWr7Qhr63rmqP5S+lWEdAItb+xo0xVOl2bai+ANlIv9hadmbiCyfzXqtbuxqak/AJCfgqIJSKomdl1za9TEu6pt0j60QO7c4mS5kIMf8ljmzleF8tzTiKwgpgzOP6arsYrAvWbajPFPlRYXRx6MuXILFrF48a00jJ0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AO+G4K1T; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AO+G4K1T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717763310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=He3juNVz7+g3hFu6GqowX6vOVAQdnb+Nrnrk3E6C7kg=;
	b=AO+G4K1TKz2gK0R0pqtOFBQX6onHl98wIbPyiRfhHVxxkyFNhUIYy3IoUNP9/mGxz82KKj
	WSmR/Xs2s7evk/LbG+hk2n+E5u9XPiXkGtFhSQil/6GsE74C/WbqLq+0sKhCLORHuotMZx
	h01a/uArvEpTyBGNoLBYyM/Wh0OWQzI=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-bawv_f8SOuiXLM-JnLAB6w-1; Fri, 07 Jun 2024 08:28:29 -0400
X-MC-Unique: bawv_f8SOuiXLM-JnLAB6w-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7024b520cbfso2179861b3a.2
        for <linux-hardening@vger.kernel.org>; Fri, 07 Jun 2024 05:28:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717763308; x=1718368108;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=He3juNVz7+g3hFu6GqowX6vOVAQdnb+Nrnrk3E6C7kg=;
        b=Mjkd5QSZA1Nii+DgjujVlPopAEoqwMInkCirtNroFSPuq/8Pn0mXkcn4dIOnAZElk+
         cdBDbYoV+zGsFPEXt58fvK+jtUXRAY1KNmn2bAMvKjdfEEfJc7CEbt/q/Jvk9Xxu/2Ug
         XeGxjbp45p8NrcKWuzSLk+N2+AHvCU1QdsGVUnhD0T3DaVhB0eGXr/TdWEi5+mg3+LUG
         ehApMCdWYK+9v6Os34f1PssuWTMb/bAEnx/1wNJKNLL3Jyjddldv68qby5NvCrXJE8JF
         idlmIG3F59ZZeAKv3oqmDlcmyHlbjQkCr/i44zhWEFl/Cwaz88v0i0QnNCopZ85lFdAF
         4jZQ==
X-Forwarded-Encrypted: i=1; AJvYcCX45/KMHgV7ltT60Y6FB0WVxWdIdKkqrtebW6RWuXpcdP7fu/vk54CDVVVrdkstg6K2RNmJdG7rvZK1QldNJfHbAO4mdzM9g/LX4AQLrXev
X-Gm-Message-State: AOJu0Yx3x/FPcAEVAX6GRBSU+GWcgaFIRrQF+czwPE83lqoSR71wHXrw
	064hqLEH59jPWlQXMaVv7lN18WCcx+L4XpuBgQ+L+t5X2CI1EzFBbL8bskIrufC5qJ+B5cZ2LMt
	8Os0DzDx2wuVfeAxy9sAn+Vt5RX6QASsUxzYpKIrFPbGD/JWS+6qybNrx9L0A4OuDsw==
X-Received: by 2002:a05:6a20:5509:b0:1b2:b688:8823 with SMTP id adf61e73a8af0-1b2f9ccbbf4mr2067786637.54.1717763307801;
        Fri, 07 Jun 2024 05:28:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+eTCa/N3Ta5x54zKKmmxUaASggmCvFDY6W9QdUswmmuERq2DgCNCpJ0Fqi3DwJXnyUNChUg==
X-Received: by 2002:a05:6a20:5509:b0:1b2:b688:8823 with SMTP id adf61e73a8af0-1b2f9ccbbf4mr2067761637.54.1717763307117;
        Fri, 07 Jun 2024 05:28:27 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-703fd530d25sm2478986b3a.213.2024.06.07.05.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 05:28:26 -0700 (PDT)
Date: Fri, 7 Jun 2024 20:27:15 +0800
From: Coiby Xu <coxu@redhat.com>
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org, Ondrej Kozina <okozina@redhat.com>, 
	Milan Broz <gmazyland@gmail.com>, Thomas Staudt <tstaudt@de.ibm.com>, 
	Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, Kairui Song <ryncsn@gmail.com>, 
	Jan Pazdziora <jpazdziora@redhat.com>, Pingfan Liu <kernelfans@gmail.com>, 
	Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Dave Hansen <dave.hansen@intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Vivek Goyal <vgoyal@redhat.com>, Kees Cook <keescook@chromium.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_byb" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v4 2/7] crash_dump: make dm crypt keys persist for the
 kdump kernel
Message-ID: <5gj3rxxf7tgolj72mxwnbjirxrlx3pezvqcegyiuenwr55njoo@6dg2toxu6vah>
References: <20240523050451.788754-1-coxu@redhat.com>
 <20240523050451.788754-3-coxu@redhat.com>
 <ZmAgNIXXa32Bv/Of@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZmAgNIXXa32Bv/Of@MiWiFi-R3L-srv>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Jun 05, 2024 at 04:22:12PM +0800, Baoquan He wrote:
>On 05/23/24 at 01:04pm, Coiby Xu wrote:
>.....
>> diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
>> new file mode 100644
>> index 000000000000..78809189084a
>> --- /dev/null
>> +++ b/kernel/crash_dump_dm_crypt.c
>> @@ -0,0 +1,113 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
[...]
>> +
>> +static unsigned int key_count;
>> +static size_t keys_header_size;
>
>These two global variables seems not so necessary. Please see comment at
>below.

Thanks for the comment! But I think it's better to keep these two static
variables for reasons as will be explained later. 

>
>> +
>> +struct dm_crypt_key {
>> +	unsigned int key_size;
>> +	char key_desc[KEY_DESC_LEN];
>> +	u8 data[KEY_SIZE_MAX];
>> +};
>> +
>> +static struct keys_header {
>> +	unsigned int key_count;
>                     ~~~~~~~~
>                     This is the max number a system have from init();
>You can add one field member to record how many key slots have been
>used.
>> +	struct dm_crypt_key keys[] __counted_by(key_count);
>> +} *keys_header;
>
>Maybe we can rearrange the keys_header like below, the name may not be
>very appropriate though.
>
>static struct keys_header {
>	unsigned int max_key_slots;
>	unsigned int used_key_slots;
>	struct dm_crypt_key keys[] __counted_by(key_count);
>} *keys_header;

Thanks for the suggestion! Since 1) KEY_NUM_MAX already defines the
maximum number of dm crypt keys 2) we only need to let the kdump kernel
now how many keys are saved, so I simply use total_keys instead of
key_count in struct keys_header in v5,

static struct keys_header {
	unsigned int total_keys;
	struct dm_crypt_key keys[] __counted_by(total_keys);
} *keys_header;

Hopefully this renaming will improve code readability.

>
>>
>
>> +
>> +static size_t get_keys_header_size(struct keys_header *keys_header,
>> +				   size_t key_count)
>> +{
>> +	return struct_size(keys_header, keys, key_count);
>> +}
>
>I personally don't think get_keys_header_size is so necessary. If we
>have to keep it, may be we can remove the global variable
>keys_header_size, we can call get_keys_header_size() and use local
>variable to record the value instead.

Thanks for the suggestion! But the kdump kernel also need to call
get_keys_header_size in later patches. 

-- 
Best regards,
Coiby

