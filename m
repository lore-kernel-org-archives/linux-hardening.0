Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CFB2A1CA
	for <linux-hardening@vger.kernel.org>; Fri, 18 Oct 2024 01:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729213538; cv=none; b=O4K0R8oaeoL82V6Btz8D6uYYor0R71eI/A0Hk2O8qhJfVK49HrCTFqFKK+D3ja5+D4hMwzrf3fCb2tR4kmr7dDN85tj6vx8PgjFkQQFMJOdCsHjiIA28F9pW374yTrhIlHyrbcjHBJpfTNgNqW7yd2BosnT4+34Nk06c4PMYCno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729213538; c=relaxed/simple;
	bh=kowSXiXyruiDJjF7LO4J2w2r2fb4k0BptEpNJwqyAk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=euy6QeOtknx3RiVPQ+ue6rd8fc3Ga9MvDSQs/dp9JzX/oftM57wjyev23fLy+uZnt3VQ/caPAF/qvyBTe7YvkiP2FO+H2TjwntvKrL5WIGtTad6xSyoCHgiebJKsNQfl+e2WtTO+g8vwt1VoNoS0UVaAcpTe5aHqiOl/FueNGu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FxxQdaEu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FxxQdaEu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729213535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=im/8jDN85o8dpsjNllcDJZk4PVI/oCZ54YgWyke0Cv8=;
	b=FxxQdaEu3g9SUIRhYISWxKhYg8lPvzdiMbaL5+/OwM3xL4ERVy8x7jhSOepO0wTUrm7Wir
	Fq9s5mhFnA2JmBtjrf66m7yJz48nxBk22N3BqqrFwBiKt4LaE1PNkGufoWzsmt5I5uTmUk
	IcPgsITrveeV1B69uqlYoTxceHpGlvI=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-sAvUfhOqOFidy5ToX4r2Kw-1; Thu, 17 Oct 2024 21:05:34 -0400
X-MC-Unique: sAvUfhOqOFidy5ToX4r2Kw-1
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-e292a6bdd72so2656907276.0
        for <linux-hardening@vger.kernel.org>; Thu, 17 Oct 2024 18:05:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729213533; x=1729818333;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=im/8jDN85o8dpsjNllcDJZk4PVI/oCZ54YgWyke0Cv8=;
        b=dsNt5UpUORxV5UJnxqwC6d7q1E9EXzwj00UJhEzdKHOQTzs1ZdKojnC+M6F4cjJXnm
         8ZoNMkfxuy0h1Qa96Fb0oZxbErfNpET8NNCdzAxpOoFU8bX9zcPJ51QaERXRL7AkHWiv
         GxEBGFIQf9xyur1Ii2ef3Zxadhntd6I4YQTcD6Ga+AHqbiFblXbBQUAZnITf6KIZD5Ug
         go3X0ylqSLJTjSYi8eew/GQCHPxH0JtZrbosoqx2guEXLwFDbu4IyjMwhV/Q+d0xQLFY
         /BHRNVI8+II5Eugq+PZmzNHq1L4eHQSJwVjWSb/afJEfBFp3rZ0nEzylPDTYzH2a68Gv
         gtww==
X-Forwarded-Encrypted: i=1; AJvYcCX3SiuhrvrJPTHNcllO7/4qlaXYp/fV0IIPih1nXGpk5+L9mps9EljW1bZHj/b1CNKpFQK19SVxHUshH8KxCwI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6ULpsVX+mlKPmSdRv1YMqWvV0lJ0nA77056w34bfpJfWKxEY0
	kF3qLdn9hhG4TGfD67cUPnlap7AUeUBfGPRIWMDGZ5seFGAuyIqf2RENTUKGWXbl3QhXE9ZTk/6
	BUsJMg2fSJyWxKgVn3lVoKEnn/d4Xu9ENiMf+0lrDRnMG7Im+HDebZGdb6fjI73OwZYw9qGLsvt
	UzmSEUXA==
X-Received: by 2002:a05:6902:2402:b0:e29:110e:6262 with SMTP id 3f1490d57ef6-e2bb168cc75mr656423276.36.1729213533050;
        Thu, 17 Oct 2024 18:05:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDlBlNRTAwPlOe5LtFgMxaSDqQm867MYlk0mBbHAqo4GOqATrNJ9lNsl2cgC6uZOG0DEq5kA==
X-Received: by 2002:a17:903:27c4:b0:20c:ad30:6b97 with SMTP id d9443c01a7336-20e5a90621dmr9397575ad.38.1729213521804;
        Thu, 17 Oct 2024 18:05:21 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e5a753378sm2444375ad.98.2024.10.17.18.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 18:05:21 -0700 (PDT)
Date: Fri, 18 Oct 2024 09:02:41 +0800
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
Message-ID: <wxsunpjqmro2ouupfvhkoc744jvfdx3g3fmg5zec6ouuibsnt5@ncdx66ndiaz2>
References: <20240523050451.788754-1-coxu@redhat.com>
 <20240523050451.788754-3-coxu@redhat.com>
 <ZmAgNIXXa32Bv/Of@MiWiFi-R3L-srv>
 <5gj3rxxf7tgolj72mxwnbjirxrlx3pezvqcegyiuenwr55njoo@6dg2toxu6vah>
 <ZmZUfWKovZLkXpJn@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZmZUfWKovZLkXpJn@MiWiFi-R3L-srv>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Jun 10, 2024 at 09:18:53AM +0800, Baoquan He wrote:
>On 06/07/24 at 08:27pm, Coiby Xu wrote:
>> On Wed, Jun 05, 2024 at 04:22:12PM +0800, Baoquan He wrote:
>> > On 05/23/24 at 01:04pm, Coiby Xu wrote:
>> > .....
>> > > diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
>> > > new file mode 100644
>> > > index 000000000000..78809189084a
>> > > --- /dev/null
>> > > +++ b/kernel/crash_dump_dm_crypt.c
>> > > @@ -0,0 +1,113 @@
>> > > +// SPDX-License-Identifier: GPL-2.0-only
>> [...]
>> > > +
>> > > +static unsigned int key_count;
>> > > +static size_t keys_header_size;
>> >
>> > These two global variables seems not so necessary. Please see comment at
>> > below.
>>
>> Thanks for the comment! But I think it's better to keep these two static
>> variables for reasons as will be explained later.
>>
>> >
>> > > +
>> > > +struct dm_crypt_key {
>> > > +	unsigned int key_size;
>> > > +	char key_desc[KEY_DESC_LEN];
>> > > +	u8 data[KEY_SIZE_MAX];
>> > > +};
>> > > +
>> > > +static struct keys_header {
>> > > +	unsigned int key_count;
>> >                     ~~~~~~~~
>> >                     This is the max number a system have from init();
>> > You can add one field member to record how many key slots have been
>> > used.
>> > > +	struct dm_crypt_key keys[] __counted_by(key_count);
>> > > +} *keys_header;
>> >
>> > Maybe we can rearrange the keys_header like below, the name may not be
>> > very appropriate though.
>> >
>> > static struct keys_header {
>> > 	unsigned int max_key_slots;
>> > 	unsigned int used_key_slots;
>> > 	struct dm_crypt_key keys[] __counted_by(key_count);
>> > } *keys_header;
>>
>> Thanks for the suggestion! Since 1) KEY_NUM_MAX already defines the
>> maximum number of dm crypt keys 2) we only need to let the kdump kernel
>> now how many keys are saved, so I simply use total_keys instead of
>> key_count in struct keys_header in v5,
>>
>> static struct keys_header {
>> 	unsigned int total_keys;
>> 	struct dm_crypt_key keys[] __counted_by(total_keys);
>> } *keys_header;
>>
>> Hopefully this renaming will improve code readability.
>
>If you add key_count into keys_header, then kdump kernel will know how
>many keys are really saved and need be retrieved. What's your concern
>when you have to put key_count outside and take it as a global variable?

Yes, the kdump kernel can know how many keys by reading keys_header. But
1st kernel needs to know how many keys are recorded so far as user space
is expected to tell the kernel which keys are needed one by one and the
key_count will be increased witch each new key.

>
>>
>> >
>> > >
>> >
>> > > +
>> > > +static size_t get_keys_header_size(struct keys_header *keys_header,
>> > > +				   size_t key_count)
>> > > +{
>> > > +	return struct_size(keys_header, keys, key_count);
>> > > +}
>> >
>> > I personally don't think get_keys_header_size is so necessary. If we
>> > have to keep it, may be we can remove the global variable
>> > keys_header_size, we can call get_keys_header_size() and use local
>> > variable to record the value instead.
>>
>> Thanks for the suggestion! But the kdump kernel also need to call
>> get_keys_header_size in later patches.
>
>If so, you can remove keys_header_size now. You can define local
>variable to take the newly calculated value. keys_header_size seems not
>so necesary.

Sure, new version will have the global variable keys_header_size
removed which can make the code a bit easier to reason about, thanks!

>
>By the way, you don't need to rush to post v5. When people review
>patches, agreement need be reached after discussion. Then next version
>can be posted.

Thanks for the suggestion! I'll wait for the consensus to be truly
reached next time.

And sorry, it takes longer time than I have expected to evaluate all the
feedback. In retrospective, maybe it's better to respond to each
feedback in a parallel manner than pondering over all the feedback
first.

-- 
Best regards,
Coiby

