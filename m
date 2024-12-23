Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A02DDA8
	for <linux-hardening@vger.kernel.org>; Mon, 23 Dec 2024 01:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734916521; cv=none; b=MY3JYZ42pNEYn59BugV422ZtCwZk2ysUFFPhMBxon0Yhs28OPuBnPLvGbe4aCtWgBPSRi7cH/tfqHrj088EShRsYzXBtjd7/XUwMIkXeGLN9N3M3RNnig/9XhkCKMcpiYslLM/ZW9OavtqGJrFWisq58qeum5hE8dFyoN2bkoJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734916521; c=relaxed/simple;
	bh=szdta1DSb04TyEgqe4No83PW3P39VAJ4myrUw2PSH0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=DMIUsEZgguwOv0qVoowqgITpO93o/f9lzKR+PRfygAkM3mq0HI9ewt+25hOedCphcpwRvsR0v+PPPFDcJT7WrllZU4KQglA+x/PxjDqNZOCt7CoPH+QKBbL975wT2hNnFQeWbvBzm2ym8nJtNalV6z2Rc6DPvCA5ImeGYvvrDv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dQi+i0/y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dQi+i0/y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734916518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7GtGrTPjZSAjzaFLtGonWMd0lc7BI8U83xboD+moXcA=;
	b=dQi+i0/ypZjkE8hirJC4rORby0CWTBE+eSeDoAZNQpaLcw+RRFDn0t0ZCUrMDOL86MgpYS
	WqXNZLzBAcxOrGJoUb9JZMUke1NVpuo3030exBGa6GDWKaaXcgo2DkwQhPztOnIXWvoTq/
	FcWLhhbhrQ99sa+Y793rZwho2nS66sc=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-j7ZgL8RFPMKZXP-BwodMQg-1; Sun, 22 Dec 2024 20:15:15 -0500
X-MC-Unique: j7ZgL8RFPMKZXP-BwodMQg-1
X-Mimecast-MFC-AGG-ID: j7ZgL8RFPMKZXP-BwodMQg
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-216311faa51so29657165ad.0
        for <linux-hardening@vger.kernel.org>; Sun, 22 Dec 2024 17:15:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734916514; x=1735521314;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7GtGrTPjZSAjzaFLtGonWMd0lc7BI8U83xboD+moXcA=;
        b=GJCFyDlUVqP00EwlkElL5A+QlCczgPHHqfNrXcrY7EmDY+FDe4DejB5U/pQQi6tb0A
         WeqH7hzndOy5VGpU9a/zCaNQahIv1QhF/HJ6GeGbRrKuni9Or6sf70mUTFjU/L0f2LQZ
         QAq+EqM7s+yW4IQ+N/yDFvSYIKRohAtAvINNTMpKetOeoFX3JssPhWq7PtREcufR7ZrB
         CYzqzrk/EKarx4R5xFyWnLKCFzvj050K6OtRaFRy39qYNNZOj7Liw9/vbDqE1B1Hdqhr
         NIi6y3AjDTpsihs5MQ6N9vHYYDuL5z2Y1DkN08H3ZSD2szkfLexHaq+Ha7WX406CNQI7
         E0/g==
X-Forwarded-Encrypted: i=1; AJvYcCXYu8beeQVXfXr3QvHY6AXbj/jrTKIMnh5LNWeem+J5/C8Q8S8my7TwseDtm+aStSwNgUhMwutSQWaOPwnzUFM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd8OCLVIdWMXp/+jI3AEqdLTXWabrNh/vNpVbk0SipxdAeqezM
	aJ/InWodlD6BflYCZtTmAPG1M04eHpjwX3LR5V7JXWE3juquW7nYH912EOpqBJMX6Qvg/t+o1q5
	FJmYBjVDZ4fOQSr9wC6O/i+kYd7ohhPTqTVO6y9fOkRzKeR1LU0ihbggN4aYyJtEJcQ==
X-Gm-Gg: ASbGncuCKwVa84wkpyamUMq0IL8FyMJs+1U4cUwjOEC0Ot0z2mOqmh8TEctu9CSKfXt
	793WqevlDlbAOfI7JMcATmBQsdshI/av0c6lOLGpGRKhDwn5h4gM1bibLMN93iChCkqWRJoTqQX
	3aWHMML0Ed1xvz4RgXrm4mwsEefFU3b8b7xovuvxV76aX4f2oHVAls8thMOCtlY6kN7lcmBHgRm
	65bswkkJjexWkdiGnBImTNWAWh0KXTS2sirQlG9TlGjAEwP
X-Received: by 2002:a17:902:c94b:b0:215:ae61:27ca with SMTP id d9443c01a7336-219e6d6b172mr171467605ad.26.1734916514211;
        Sun, 22 Dec 2024 17:15:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFocO6jig5LTrbgs3S+saJG3scABAfxvAhM+xo8TvafP29KiOHQcqp7+zxDBRXZZoeI4x+aBg==
X-Received: by 2002:a17:902:c94b:b0:215:ae61:27ca with SMTP id d9443c01a7336-219e6d6b172mr171467285ad.26.1734916513909;
        Sun, 22 Dec 2024 17:15:13 -0800 (PST)
Received: from localhost ([180.109.216.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc964e92sm62299365ad.18.2024.12.22.17.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Dec 2024 17:15:13 -0800 (PST)
Date: Mon, 23 Dec 2024 09:05:41 +0800
From: Coiby Xu <coxu@redhat.com>
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org, Ondrej Kozina <okozina@redhat.com>, 
	Milan Broz <gmazyland@gmail.com>, Thomas Staudt <tstaudt@de.ibm.com>, 
	Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, Kairui Song <ryncsn@gmail.com>, 
	Jan Pazdziora <jpazdziora@redhat.com>, Pingfan Liu <kernelfans@gmail.com>, 
	Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Dave Hansen <dave.hansen@intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Greg KH <gregkh@linuxfoundation.org>, Vivek Goyal <vgoyal@redhat.com>, 
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_byb" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v6 3/7] crash_dump: store dm crypt keys in kdump reserved
 memory
Message-ID: <lzulibhdxvlhqdsszxcrejjcdbzwb4643nlqtd2hh6nbjb5mz4@ky2jhelzy4md>
References: <20241029055223.210039-1-coxu@redhat.com>
 <20241029055223.210039-4-coxu@redhat.com>
 <Z1mMc+/dCk+mSahu@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Z1mMc+/dCk+mSahu@MiWiFi-R3L-srv>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wtxVY_jovF3C5z_oK12qs_W4x_BTSNlohLYxlfE3Hr0_1734916514
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Dec 11, 2024 at 08:58:27PM +0800, Baoquan He wrote:
>On 10/29/24 at 01:52pm, Coiby Xu wrote:
>......
>> +int crash_load_dm_crypt_keys(struct kimage *image)
>> +{
>> +	struct kexec_buf kbuf = {
>> +		.image = image,
>> +		.buf_min = 0,
>> +		.buf_max = ULONG_MAX,
>> +		.top_down = false,
>> +		.random = true,
>> +	};
>> +	int r;
>> +
>> +
>> +	if (key_count <= 0) {
>> +		kexec_dprintk("No dm-crypt keys\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	image->dm_crypt_keys_addr = 0;
>> +	r = build_keys_header();
>> +	if (r)
>> +		return r;
>> +
>> +	kbuf.buffer = keys_header;
>> +	kbuf.bufsz = get_keys_header_size(key_count);
>> +
>> +	kbuf.memsz = kbuf.bufsz;
>> +	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
>> +	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
>> +	r = kexec_add_buffer(&kbuf);
>> +	if (r) {
>> +		kvfree((void *)kbuf.buffer);
>> +		return r;
>> +	}
>> +	image->dm_crypt_keys_addr = kbuf.mem;
>> +	image->dm_crypt_keys_sz = kbuf.bufsz;
>
>Wondering why not assigning kbuf.memsz, but bufsz.

Thanks for the question! I think there is no need to use kbuf.memsz
after reading the code on setting image->elf_headers_sz. Currently all
arches except for x86 CONFIG_CRASH_HOTPLUG assigns kbuf.bufsz to
image->elf_headers_sz. For x86 CONFIG_CRASH_HOTPLUG, if I understand it
correctly, it assigns kbuf.memsz to kbuf.memsz because elfcorehdr
changes when there is memory/CPU hot-plugging. For dm crypt keys, there
is no so such concern, so assigning kbuf.bufsz shall be OK.

-- 
Best regards,
Coiby

