Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A8B19415E
	for <linux-hardening@vger.kernel.org>; Fri,  7 Jun 2024 12:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717763303; cv=none; b=tR/1vsYutxlW0CXQfiqaVBZ3n/ZX5PP++5oUSymvEQAPI5BgRC4vyyJABkFDRNxxpMNq5MbSAe1tYbdbio3EWoXI+GYaI1dTbinJc11BcxnHrWwHRiUKjbDvltr0an6X0WRB2yutP4XguiLoRer4P1d0OEQtLjAJKAOiRBGTLIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717763303; c=relaxed/simple;
	bh=2F/1Pw7fg7p1sCas1pMb+GrJ4VRYXNwcvb/GukSp7IA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=C9ZzwYfuGn4UFpbdbX3ZbtTh7FBxC+4BhWp2C22GLssIDr1Tv2tJ5Yfr3pHMgdzD3BB+kjFgpkPcBu6Dtts4d5ThEqmtLNx77obY1olwAhRBhXJ1b+FGxIgavEKO97FqC8X2Aa0k0fZSmke6hzrrhfNvCGL8PSQyVp+RnicNkGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wv+lbW9m; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wv+lbW9m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717763301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FypPKgT3pJsp6KviCFXO/ORbTvZxCPQ2jaD/DLtQnPQ=;
	b=Wv+lbW9mJWyv+0ca23oXV535j4WiY4KeWE1sE7A2O8GrgOwFFaq3ZyqKyAU785Vai1tjm2
	tW/0IFrn8GqMVWs4R1N8UdEoBGgMhaOiTF7ssq74ChJc8TTBCFD5BJTiTQnIyWMNkKEVDR
	qAza59gjwBcAp4S39I1LXmxHD/bGReY=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-dxFhw7tyMX62ioA0YdnCDg-1; Fri, 07 Jun 2024 08:28:20 -0400
X-MC-Unique: dxFhw7tyMX62ioA0YdnCDg-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6fb22ecd976so1413939b3a.1
        for <linux-hardening@vger.kernel.org>; Fri, 07 Jun 2024 05:28:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717763298; x=1718368098;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FypPKgT3pJsp6KviCFXO/ORbTvZxCPQ2jaD/DLtQnPQ=;
        b=lF1uQg7E22KLuH2ic3+9uL0OKOf3SpuwmBApF5qZsDhwBfk6HYmcN31mG1SNcqUA7i
         eKvZRSBxY2KIpwv5ghnHJuVikfrPz2Ybo4iO9YMd33xLfYc7iNPv3hz8CWCWMSp0n45k
         VXGxfk5DkYCZxku/9bY9bfA3/cV8nSjFLQgJWYsN0DpHlnoM4Oj3FrUApw7d9e5AKqr3
         YpRfXcQzLU963bVR6By4TLBp0mE6N5t7g2qmyNt3CHyrcUDHoiyoBOygK3mISk8LoXsK
         HpKScR0mi4rPhK/EIpVXy68gWo7yOkd/Pxkuj0giaOoCiMnBx4wRIf1JwrseEcG4jAjP
         6lBg==
X-Forwarded-Encrypted: i=1; AJvYcCXeOAl+UUUPI9QPXMJo36tPv9oMi5Hqel0wt7nYFgBnMR5kHEVx/gz9aDgAIPG/8+cc7jWfe6MvBHK1AKMnUj5iP4xkxd3qXXrKuyHRuETA
X-Gm-Message-State: AOJu0YwyHRSSZLEaDodzdoyXw7vaByKgy7gfkkTFkJzUmW2qt5CnACwX
	AZz/tgeshlEEMUegrlEgCWZ4cVphl+Nq+rwSbULRsw5qQzY5TQ0q5poYOnd5rMgGcV1ShKZ4uCB
	i7zbXC0Ndt3Y1aW6+gmOAYzY+NeFuFFbrFy0mLb4th6xJTUEzfGBqlMaC9uH1V9Aq5w==
X-Received: by 2002:a05:6a00:23c2:b0:6ed:825b:30c0 with SMTP id d2e1a72fcca58-703f88de73amr7817548b3a.15.1717763297897;
        Fri, 07 Jun 2024 05:28:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqa9G1P1Nfp6M4MFxgwat4T28EeXX617ZqUou6xSlSloKgK/kupjGqVmTHU4L88C/jIn2KRQ==
X-Received: by 2002:a05:6a00:23c2:b0:6ed:825b:30c0 with SMTP id d2e1a72fcca58-703f88de73amr7817489b3a.15.1717763297022;
        Fri, 07 Jun 2024 05:28:17 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-703fd3a3a87sm2486990b3a.82.2024.06.07.05.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 05:28:16 -0700 (PDT)
Date: Fri, 7 Jun 2024 20:27:07 +0800
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
Message-ID: <epa3mtnac3ekyoq7zykyjnhu3i27mivbtlkss6mbjyaa3kmhof@qwbfshfbtei4>
References: <20240523050451.788754-1-coxu@redhat.com>
 <20240523050451.788754-3-coxu@redhat.com>
 <Zl7Vd3BqxDXdMHkL@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Zl7Vd3BqxDXdMHkL@MiWiFi-R3L-srv>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Jun 04, 2024 at 04:51:03PM +0800, Baoquan He wrote:
>Hi Coiby,

Hi Baoquan,

>
>On 05/23/24 at 01:04pm, Coiby Xu wrote:
>> A sysfs /sys/kernel/crash_dm_crypt_keys is provided for user space to make
>> the dm crypt keys persist for the kdump kernel. User space can send the
>> following commands,
>> - "init KEY_NUM"
>>   Initialize needed structures
>> - "record KEY_DESC"
>>   Record a key description. The key must be a logon key.
>>
>> User space can also read this API to learn about current state.
>
>From the subject, can I think the luks keys will persist forever? or
>only for a while? 

Yes, you are right. The keys need to stay in kdump reserved memory.

> If need and can only keep it for a while, can you
>mention it and tell why and how it will be used. Because you add a lot
>of codes, but only simply mention the sysfs, that doesn't make sense.

Thanks for raising the concern! I've added
Documentation/ABI/testing/crash_dm_crypt_keys and copy some text in the
cover letter to this patch in v5. 

>
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
[...]
>> +static int init(const char *buf)
>              ~~~~ A more interesting name with more description?

Thanks for the suggestion! I've added some comments for this function
in v5. But I can't come up with a better name after looking at current
kernel code. You are welcome to suggest any better name:)

>> +static int process_cmd(const char *buf, size_t count)
>                                                  ~~~~
>If nobody use the count, why do you add it?

Good catch! Yes, this is no need to use count in v4. But v5 now needs it to avoid
buffer overflow.

-- 
Best regards,
Coiby

