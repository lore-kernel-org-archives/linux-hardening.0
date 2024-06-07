Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE33819309B
	for <linux-hardening@vger.kernel.org>; Fri,  7 Jun 2024 12:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717763300; cv=none; b=Y0nc4AgchUmpOnVsiVlmbK6EpUFqT3CScflKM2z4wzBiOVulvPjhI1VGUcREJ8FrBgTPBgP+xGTWPKl9X9as52JxSRr8audP1woSfOP0wibWEDpoj8lu5p6vZcjGUQhuOhopjn9OsNmtMYNF1j3LU1ve4qBKu7TRx5QYCgLwMmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717763300; c=relaxed/simple;
	bh=1aAMjrd4AzwLefMt1KVwrNuAUPL1gW3qkJxQ6CaUyXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ulLeUY5Q2+FPzz1XmAYjGKc3ARG7O3RDn/6iTZdNJEMHQNd/EGgADrer5z8LtoN2CN3vNjbkRBUISQG5d1t5rXgCHLGDriEIR6UyiYHQQWdRW0vfNh+zXEeK2MMWim9/FWhTa0D5JWYp3lBdvUV+k8YrgbKJ5cMYPVZpaM/96QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RvbYuXN8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RvbYuXN8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717763297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/t6956UOv5lCksdjLk7UvP2/agO8Fjf4ixoixsQ5vC4=;
	b=RvbYuXN8LSmBVwXnIS34AmidiMPHxxrpWzoO7HZF8z8mkCcXSlhMSgKWns8bvH/kgpxl3n
	Rf43yjLm9zl4e848QzNTtPKPwKm8J8NhWEQbO7Rgnvzi7nZ1sTFy8cDDX7+qlAfVsYEIKD
	xXHgR4pBMtN8jeO3r/88oA9VDhS6Jug=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-20GL_MXhOz-GtTs-bAneKQ-1; Fri, 07 Jun 2024 08:28:14 -0400
X-MC-Unique: 20GL_MXhOz-GtTs-bAneKQ-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-70243d69054so2059761b3a.0
        for <linux-hardening@vger.kernel.org>; Fri, 07 Jun 2024 05:28:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717763294; x=1718368094;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/t6956UOv5lCksdjLk7UvP2/agO8Fjf4ixoixsQ5vC4=;
        b=e+TLvNRrE24MpRcLdK+UJGSFjnalsGLdljTQkFlcRPwUn/BAa9/V1aeIBO8rVmBwI2
         lxaxDeEK4siNL5jIzCrAfyIu/VXWCZaeXFTsVZokRtSTTXyHp46/jnnAOZZdw9oRoN3Q
         0oasVx7HMZIi8rpdBwVDGXzzH+WlfqAMkRaWO4h05j+i/5ThabPhYlIVNvLYqYtZF+Te
         F2THW34j5jZsZZEdYs3kUe4CbIJWTfQaYNwK4kDxTOSraW3BxvGp2f+MPpvDxWM42NUt
         JKr9oRA+9T456DPKsRQ4T8BLQGStHRUy3w1RLgKfpSP5fVpOexLTZ0ff82/cbjDEEw5V
         v+fA==
X-Forwarded-Encrypted: i=1; AJvYcCVilcnixkV7DiLJh20HMKCWsjeduioVJSKB9yMWUNfDSyTFqwRU0rZDfPh405S5TCARDS2pY66TAGf2GjyY33nDk8VUP4Iq3PP1+J6DP5TS
X-Gm-Message-State: AOJu0Yxdj/ew4nDu/nwFct9eVm2mxa0bwFkZTKefUgRgHOtU/sJn9cfT
	2Qnu9ZE3J07oJzqFNyW4Odgi6u13OAUMjrl/N9Ymkze0OvbOZr74nd4Fldmu5g/ky30iWEZ8zOS
	04JAPuPyQQfnl6rY03jWtrj+IpkbMd5rivBUjRYIHl0HnF4oAEPGJEAL+1+sEQrO/1Q==
X-Received: by 2002:a05:6a21:32a7:b0:1b4:68a2:908b with SMTP id adf61e73a8af0-1b468b1d6b1mr654915637.14.1717763292870;
        Fri, 07 Jun 2024 05:28:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQo9mPlRLCIa6N5kRoMuchaJ04EmyjXCzB3G/zjo7E3SC6tybqM+xniohJslEjmSTV/Ig+lw==
X-Received: by 2002:a05:6a21:32a7:b0:1b4:68a2:908b with SMTP id adf61e73a8af0-1b468b1d6b1mr654885637.14.1717763292099;
        Fri, 07 Jun 2024 05:28:12 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70410b976a9sm942536b3a.147.2024.06.07.05.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 05:28:11 -0700 (PDT)
Date: Fri, 7 Jun 2024 20:26:54 +0800
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
Message-ID: <y5ah5hdueqh5l5m4ll6qdebvnkvkdfbghvjprgyfeacajo3nhj@zg7qj6vfo3w6>
References: <20240523050451.788754-1-coxu@redhat.com>
 <20240523050451.788754-3-coxu@redhat.com>
 <ZmEo4rw8Yhu7tspb@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZmEo4rw8Yhu7tspb@MiWiFi-R3L-srv>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, Jun 06, 2024 at 11:11:30AM +0800, Baoquan He wrote:
>On 05/23/24 at 01:04pm, Coiby Xu wrote:
>> A sysfs /sys/kernel/crash_dm_crypt_keys is provided for user space to make
>> the dm crypt keys persist for the kdump kernel. User space can send the
>> following commands,
>> - "init KEY_NUM"
>>   Initialize needed structures
>> - "record KEY_DESC"
>>   Record a key description. The key must be a logon key.
>
>This patch highly lack document to describe what it's doing. For
>example, how you will manipulate the /sys/kernel/crash_dm_crypt_keys to
>initialize, record the keys, can you give examples how you opeate on
>them?

Thanks for the suggestion! v5 now includes
Documentation/ABI/testing/crash_dm_crypt_keys.

>
>>
>> User space can also read this API to learn about current state.
>>
>> Signed-off-by: Coiby Xu <coxu@redhat.com>
>> ---
>>  include/linux/crash_core.h   |   5 +-
>>  kernel/Kconfig.kexec         |   8 +++
>>  kernel/Makefile              |   1 +
>>  kernel/crash_dump_dm_crypt.c | 113 +++++++++++++++++++++++++++++++++++
>>  kernel/ksysfs.c              |  22 +++++++
>>  5 files changed, 148 insertions(+), 1 deletion(-)
>>  create mode 100644 kernel/crash_dump_dm_crypt.c
>>
>> diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
>> index 44305336314e..6bff1c24efa3 100644
>> --- a/include/linux/crash_core.h
>> +++ b/include/linux/crash_core.h
>> @@ -34,7 +34,10 @@ static inline void arch_kexec_protect_crashkres(void) { }
>>  static inline void arch_kexec_unprotect_crashkres(void) { }
>>  #endif
>>
>> -
>> +#ifdef CONFIG_CRASH_DM_CRYPT
>> +int crash_sysfs_dm_crypt_keys_read(char *buf);
>> +int crash_sysfs_dm_crypt_keys_write(const char *buf, size_t count);
>> +#endif
>>
>>  #ifndef arch_crash_handle_hotplug_event
>>  static inline void arch_crash_handle_hotplug_event(struct kimage *image, void *arg) { }
>> diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
>> index 6c34e63c88ff..88525ad1c80a 100644
>> --- a/kernel/Kconfig.kexec
>> +++ b/kernel/Kconfig.kexec
>> @@ -116,6 +116,14 @@ config CRASH_DUMP
>>  	  For s390, this option also enables zfcpdump.
>>  	  See also <file:Documentation/arch/s390/zfcpdump.rst>
>>
>> +config CRASH_DM_CRYPT
>> +	bool "Support saving crash dump to dm-crypt encrypted volume"
>> +	depends on CRASH_DUMP
>
>Do we need add dependency on some security features, e.g KEYS?
>The current code will enable the CRASH_DM_CRYPT regardless of the
>existence of LUKS disk at all.

Good suggestion! I make CRASH_DM_CRYPT depend on DM_CRYPT in v5.

> [...]
>> +static int init(const char *buf)
>> +{
>> +	unsigned int total_keys;
>> +	char dummy[5];
>> +
>> +	if (sscanf(buf, "%4s %u", dummy, &total_keys) != 2)
>> +		return -EINVAL;
>
>This is what I wondered and tried to find a document to get why. Can we
>search in the current system and deduce how many keys we can could use
>for kdump kernel? Or we have to retrieve and pass it from user space?

I don't think we can get this info from the kernel space directly
because the kernel don't know the kdump target. So we have to pass this
info from user space.

>
>> +
>> +	if (key_count > KEY_NUM_MAX) {
>> +		pr_err("Exceed the maximum number of keys (KEY_NUM_MAX=%u)\n",
>> +		       KEY_NUM_MAX);
>> +		return -EINVAL;
>> +	}
>
>Why chekcing key_count in init()? Don't you need to check
>total_keys instead? Clearly you don't do a boundary test for total_keys,
>otherwise it will trigger issue.

Good catch! Yes, I should check total_keys instead.

>
>> +
>> +	keys_header_size = get_keys_header_size(keys_header, total_keys);
>> +	key_count = 0;
>> +
>> +	keys_header = kzalloc(keys_header_size, GFP_KERNEL);
>> +	if (!keys_header)
>> +		return -ENOMEM;
>> +
>> +	keys_header->key_count = total_keys;
>> +	state = INITIALIZED;
>> +	return 0;
>> +}
>
>Please add more code comments, kernel-doc for your code, we can't assume
>people reading these codes know the entire matter.

Thanks for the suggestion! I've added some comments and documentation in
v5. Please let me know if there is anything more to improve.

-- 
Best regards,
Coiby

