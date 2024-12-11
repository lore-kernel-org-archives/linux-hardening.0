Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FBC23FD23
	for <linux-hardening@vger.kernel.org>; Wed, 11 Dec 2024 12:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733921928; cv=none; b=b6UnV4/LtZRhrb9HwAdmIddQCuCp9Xj9NGrup6Icmb7+Ah3o5y7TSWE2jyJhz0fuYNirwmKmN7e5U5Xk1aMM0HretVPM6ZJwDX7gTI7r3YQs7a8XBtiwTELOzUJLS0srA+Aw6eknEW6NXX2egMXPJ/kCCbUdOmYOUnqnyjYXqE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733921928; c=relaxed/simple;
	bh=KEAn6OuOqUG3OsVVxWOZfTx8NtgFmhCRRDwlZmd0Oh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nOfIxZ6Pm9tkcg+0mOtbSRrXtEXPBzMqS6ca1fBe/85E9jBYY4UODb+lVgKzWu4iwS9w0GbYlIWA5C/diMk2gxalMLel2ouv0ffRVVVV2RV4ZX7DB2Zh7kJ2zlFccppHf+/dmkAEdznKdhDG2xNyEha2tiBjx9+5OoJNGqtiluM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CvZRiIn4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CvZRiIn4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733921925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+DEcDh+LdwGMntwkxIbCzkLoVBb89ABtlpvYyrYztn0=;
	b=CvZRiIn43pzllFdN7DGuEroWhqo9wvog1nuXwDwV43wFTVvXobjcjVx78YymERmLhuYTdm
	RIIDQ3rTCUp/uFOxpc8otbSr8IA5RC3hJjezukgpB0b8B6zwXgC3FZ+7borY+bTBok4nfP
	etnVO8bOkIUOOxPReEuHIxc0+EP0u+I=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-_hM7nGCVOMm_QIe9A0sMKw-1; Wed,
 11 Dec 2024 07:58:42 -0500
X-MC-Unique: _hM7nGCVOMm_QIe9A0sMKw-1
X-Mimecast-MFC-AGG-ID: _hM7nGCVOMm_QIe9A0sMKw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 905441956089;
	Wed, 11 Dec 2024 12:58:40 +0000 (UTC)
Received: from localhost (unknown [10.72.112.3])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 29C59300018D;
	Wed, 11 Dec 2024 12:58:32 +0000 (UTC)
Date: Wed, 11 Dec 2024 20:58:27 +0800
From: Baoquan He <bhe@redhat.com>
To: Coiby Xu <coxu@redhat.com>
Cc: kexec@lists.infradead.org, Ondrej Kozina <okozina@redhat.com>,
	Milan Broz <gmazyland@gmail.com>,
	Thomas Staudt <tstaudt@de.ibm.com>,
	Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
	Kairui Song <ryncsn@gmail.com>,
	Jan Pazdziora <jpazdziora@redhat.com>,
	Pingfan Liu <kernelfans@gmail.com>, Dave Young <dyoung@redhat.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Dave Hansen <dave.hansen@intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Vivek Goyal <vgoyal@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_byb" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v6 3/7] crash_dump: store dm crypt keys in kdump reserved
 memory
Message-ID: <Z1mMc+/dCk+mSahu@MiWiFi-R3L-srv>
References: <20241029055223.210039-1-coxu@redhat.com>
 <20241029055223.210039-4-coxu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029055223.210039-4-coxu@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 10/29/24 at 01:52pm, Coiby Xu wrote:
......
> +int crash_load_dm_crypt_keys(struct kimage *image)
> +{
> +	struct kexec_buf kbuf = {
> +		.image = image,
> +		.buf_min = 0,
> +		.buf_max = ULONG_MAX,
> +		.top_down = false,
> +		.random = true,
> +	};
> +	int r;
> +
> +
> +	if (key_count <= 0) {
> +		kexec_dprintk("No dm-crypt keys\n");
> +		return -EINVAL;
> +	}
> +
> +	image->dm_crypt_keys_addr = 0;
> +	r = build_keys_header();
> +	if (r)
> +		return r;
> +
> +	kbuf.buffer = keys_header;
> +	kbuf.bufsz = get_keys_header_size(key_count);
> +
> +	kbuf.memsz = kbuf.bufsz;
> +	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
> +	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
> +	r = kexec_add_buffer(&kbuf);
> +	if (r) {
> +		kvfree((void *)kbuf.buffer);
> +		return r;
> +	}
> +	image->dm_crypt_keys_addr = kbuf.mem;
> +	image->dm_crypt_keys_sz = kbuf.bufsz;

Wondering why not assigning kbuf.memsz, but bufsz.

> +	kexec_dprintk(
> +		"Loaded dm crypt keys to kexec_buffer bufsz=0x%lx memsz=0x%lx\n",
> +		kbuf.bufsz, kbuf.bufsz);
> +
> +	return r;
> +}
> +
> +
>  static int __init configfs_dmcrypt_keys_init(void)
>  {
>  	int ret;
> -- 
> 2.47.0
> 

