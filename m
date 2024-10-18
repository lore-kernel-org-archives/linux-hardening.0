Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAE91E493
	for <linux-hardening@vger.kernel.org>; Fri, 18 Oct 2024 01:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729215927; cv=none; b=InetElnt+gAtJbs0zoMSY3ZpzfGfk1Gd+gVYFqeX8phSvCUhLB0cON/iVzBye22vh3UWZHyCRwxE67cN+3z4q+gm628yfo6qLzATbncl63N/G7trAHLWaYXfSRimyN5NqanVjPyiUt22es0/559Zpm7Qi2PAcMAAmMNi61Atog4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729215927; c=relaxed/simple;
	bh=HhGqju8S4i+h0vgWhruDzJx0Jj3wbFunfCUir7iEacQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=spWSnNWGMjaToYdTsTUs0tPRcZzN/tQh5wifoWagX25n6+J6IrGyrPopI1rXeXIN/3auNjw143dZOYo0SXImVQW0nQI6D5AAR59HoSqRlMrkt4kArvMtLNS/FuOpQ1f1xpMmAVzrskpJJGj5idcl4S14Pp1YARtHhQJChuRla1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aXicDse8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aXicDse8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729215924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kF9L/0/jEWIqoyh3hjUFK/h0JiArykMrlHze3wNZf+8=;
	b=aXicDse8Er+6wHLzNqOJExUdftCaq915PJM5BNb5GQ1QlLZtQUTyES9CLrIiVD4JGKunC6
	/pMXQUZSi0cf6WA+K4bgnuv+uV730v1uNUYIeyJ82pJQU38UV9r9+PllC0bLKv2tHZ0+Jq
	QB+LYmrDOfw5e2jxPNegrVS46Pzvnj0=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-9pZDG52UPVuQZKl0_xC58Q-1; Thu, 17 Oct 2024 21:45:23 -0400
X-MC-Unique: 9pZDG52UPVuQZKl0_xC58Q-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-7cd9ac1fa89so1650963a12.1
        for <linux-hardening@vger.kernel.org>; Thu, 17 Oct 2024 18:45:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729215922; x=1729820722;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kF9L/0/jEWIqoyh3hjUFK/h0JiArykMrlHze3wNZf+8=;
        b=rPqQPiJblHJZsyhRvhO4+PUwuS2DAktJNQmn74v3BQC76hXTV9boZeaAhfoP8eTDEQ
         c1LqjBG+U3s1tLAUGt13FLPbHTOvQJxWjMqq/liVa1D/eauoB3tgT1PGNdC5uDeYAnGD
         VIyPdzLvnsApxF6ZeFXL23vj/Gc0Wdk2Qbt/D4UGAsKuB73DjAQLlRaXEAPn47wWRilI
         a5QTQXLA2OleIAq0Lzbb6JrSoBzqG4WtadFJzMJvUxO2+8kHOlCkj6Np0tre45uGF9dB
         LH4m+0xRmfOS56Q+gOXkEs646R5NXEL7NZ1fy+1w+KIiVXxxNzF2tSVI+qrjRf3MBxBv
         sOYg==
X-Forwarded-Encrypted: i=1; AJvYcCXlKfmU/YyqKL5J/tERtfHF80dsJ3HQpnuP3TN86HmrheJNKKcX0sF7YqJAEg1pg6VCsU81AHHNXpRWs7QGXpI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYEysKvC8Avk6Pj5G/T0ylCND8sEpLnVlhY/tfLPotF7oHUci8
	DEIQGDdaT0+qlMg7/tVJ+8+NT3ySkhPWiSVk1uGL38p5eZ6dKnl47TeMlIV/165ahDg4RZuQC/T
	FAqukz8/PiIppQBE2FTib28hC+ekgR19G37jJ9QHf1HmufwUc0ESkF/z0K8DMUaofcA==
X-Received: by 2002:a05:6a21:1706:b0:1d8:b076:d9ad with SMTP id adf61e73a8af0-1d92c57bcfemr1283442637.40.1729215922018;
        Thu, 17 Oct 2024 18:45:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELXI3rWpUnWGTn+OFPj0VKUMIIHmOrQ9N8JxvRbg/oBYI+G6/m6Fxjefu3RxKAlgaDRIhjcA==
X-Received: by 2002:a05:6a21:1706:b0:1d8:b076:d9ad with SMTP id adf61e73a8af0-1d92c57bcfemr1283424637.40.1729215921594;
        Thu, 17 Oct 2024 18:45:21 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ea345b45fsm333944b3a.177.2024.10.17.18.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 18:45:21 -0700 (PDT)
Date: Fri, 18 Oct 2024 09:44:37 +0800
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
Message-ID: <enehvyzptsb2daxnsybmkv5byeqrebgcgwpz3tlmqwpwfaxtmm@ca57dtcsmyna>
References: <20240523050451.788754-1-coxu@redhat.com>
 <20240523050451.788754-3-coxu@redhat.com>
 <Zl7Vd3BqxDXdMHkL@MiWiFi-R3L-srv>
 <epa3mtnac3ekyoq7zykyjnhu3i27mivbtlkss6mbjyaa3kmhof@qwbfshfbtei4>
 <ZmZeJVa/kpyfZ47g@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZmZeJVa/kpyfZ47g@MiWiFi-R3L-srv>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Jun 10, 2024 at 10:00:05AM +0800, Baoquan He wrote:
>On 06/07/24 at 08:27pm, Coiby Xu wrote:
>> On Tue, Jun 04, 2024 at 04:51:03PM +0800, Baoquan He wrote:
>> > Hi Coiby,
>>
>> Hi Baoquan,
>>
>> >
>> > On 05/23/24 at 01:04pm, Coiby Xu wrote:
>> > > A sysfs /sys/kernel/crash_dm_crypt_keys is provided for user space to make
>> > > the dm crypt keys persist for the kdump kernel. User space can send the
>> > > following commands,
>> > > - "init KEY_NUM"
>> > >   Initialize needed structures
>> > > - "record KEY_DESC"
>> > >   Record a key description. The key must be a logon key.
>> > >
>> > > User space can also read this API to learn about current state.
>> >
>> > From the subject, can I think the luks keys will persist forever? or
>> > only for a while?
>>
>> Yes, you are right. The keys need to stay in kdump reserved memory.
>
>Hmm, there are two different concepts we may need differentiate. From
>security keys's point of view, the keys need be stored for a while so
>that kdump loading take action to get it, that's done through sysfs;
>Froom kdump's point of view, the keys need be stored forever till kdump
>kernel use it. I can't see what you are referring to from the subject,
>esepcially you stress the newly added sysfs
>/sys/kernel/crash_dm_crypt_keys.

Thanks for the suggestion! The patch set's goal is make the kdump kernel
to be able to unlock encrypted volumes so the keys have always to be
there to be ready for the kdump kernel. In fact, the 1st kernel also
keeps the keys in runtime memory because I/O data could be written back
to disk anytime and thus needs to be encrypted with the keys anytime.
But keys are sensitive data so we try to make it as safe as possible and
one measure for example to make it stay in the keyring for relatively
short time.  I'll add a note in next version's commit message. Together
with the info of the life cycle of keys, hopefully it will bring some
clarities

>
>>
>> > If need and can only keep it for a while, can you
>> > mention it and tell why and how it will be used. Because you add a lot
>> > of codes, but only simply mention the sysfs, that doesn't make sense.
>>
>> Thanks for raising the concern! I've added
>> Documentation/ABI/testing/crash_dm_crypt_keys and copy some text in the
>> cover letter to this patch in v5.
>>
>> >
>> > >
>> > > Signed-off-by: Coiby Xu <coxu@redhat.com>
>> > > ---
>> > >  include/linux/crash_core.h   |   5 +-
>> > >  kernel/Kconfig.kexec         |   8 +++
>> > >  kernel/Makefile              |   1 +
>> > >  kernel/crash_dump_dm_crypt.c | 113 +++++++++++++++++++++++++++++++++++
>> > >  kernel/ksysfs.c              |  22 +++++++
>> > >  5 files changed, 148 insertions(+), 1 deletion(-)
>> > >  create mode 100644 kernel/crash_dump_dm_crypt.c
>> > >
>> > > diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
>> > > index 44305336314e..6bff1c24efa3 100644
>> > > --- a/include/linux/crash_core.h
>> > > +++ b/include/linux/crash_core.h
>> > > @@ -34,7 +34,10 @@ static inline void arch_kexec_protect_crashkres(void) { }
>> > >  static inline void arch_kexec_unprotect_crashkres(void) { }
>> > >  #endif
>> [...]
>> > > +static int init(const char *buf)
>> >              ~~~~ A more interesting name with more description?
>>
>> Thanks for the suggestion! I've added some comments for this function
>> in v5. But I can't come up with a better name after looking at current
>> kernel code. You are welcome to suggest any better name:)
>
>Usually init() is for the whole driver module. Your init() here only
>receive the passed total keys number, and allocate the key_header, how
>can you simply name it init()? If you call it init_keys_header(), I
>would think it's much more meaningful.

Good suggestion! Yes, init_keys_header would be a much better choice!
Unfortunately a new version will switch to configfs. So I will keep this
lesson in mind and try to apply it to similar cases in the future.

>
>>
>> > > +static int process_cmd(const char *buf, size_t count)
>> >                                                  ~~~~
>> > If nobody use the count, why do you add it?
>>
>> Good catch! Yes, this is no need to use count in v4. But v5 now needs it to avoid
>> buffer overflow.
>
>OK, did you add code comment telling what 'count' stands for?
>
>And the name 'process_cmd()' is also ambiguous. We may need avoid this
>kind of name, e.g process_cmd, do_things, handle_stuff. Can you add a
>more specific name?

As new version will switch to configfs, process_cmd will no longer be
needed. But I'll try coming up with better names in the future. Thanks!

-- 
Best regards,
Coiby

