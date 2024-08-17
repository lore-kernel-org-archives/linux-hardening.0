Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0A29454
	for <linux-hardening@vger.kernel.org>; Sat, 17 Aug 2024 21:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723929457; cv=none; b=EGZN2qLlV2x8wMpA0ueP8NLL0HfnElYt6UOyXBIt3TQnUCg/d76S4VOn44n2kw7K5SoBuKrxk4HTJCk4KKO2+Y6b9KeowfBhwtktVQTdRxTXMj1E5cfP6CQfx2DL9U9C7qg3tGIHtGxQeq924uN+rgreLfzEOwrw/5jgJO1wCZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723929457; c=relaxed/simple;
	bh=t3rvDnO7fX+n5iehy8S2ishviq6i/2esDfQRovIDAKs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=f8xQYSsPUa1+T+z596u8DXnSrj4hvKzRPahV9mdanLll2ywtyC1rOsD1/nnlGfxvDk961edTgPpgNaCODFQ6qoxro7xQUGA2VHB320K09vjnyonySLk5yYie3UVA0G8SHEE3aNdHm/I/zw6JnCSTvNrYgsH2zuFtnWFVR0ok+0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=lppJQWCP; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="lppJQWCP"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-428085a3ad1so25759185e9.1
        for <linux-hardening@vger.kernel.org>; Sat, 17 Aug 2024 14:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1723929455; x=1724534255; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mlOuZvyYI02m8rApw3+B2vEhpdkz/PwxBJHifhLBStE=;
        b=lppJQWCPcpshq8T0IPKt72NiJo83JBrecdIvYWDtnjlm+mtpJdjO4rch460/vVOjvM
         rCEBFmpuyXzblyTxa8ihuVD28jXyt7YVuxKdftHrDETdT2olTOljiCwWwVziDzHK41wn
         XMNGwDUwFRasujlXJQH3c6Ww5PqM6Uf2SJ2jzIzHnJ9eLicH6fg1vrUpAg6X/QDvGLD1
         auf8CsRZrFRa1G6xXQdL3r790HHitLjFdgBpYCuq9r+o4rLpCr2Vg2oArMRZveD4Q03o
         K4TSue/KaoldoGtni9nrxBUjSJ1gbIwV+dbxQAc+lrjbBoftvv7YLBOnXjxLkt5MjF/h
         YqGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723929455; x=1724534255;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mlOuZvyYI02m8rApw3+B2vEhpdkz/PwxBJHifhLBStE=;
        b=QDnKw/e79L6MU/gJwirKtYBxqM4OBZwatSY/rAvPeL1Tqegj1Vs03FPLc+8bMMW2sE
         LO0qeXojvEXDwCnfkidM6epzK10yESXJQmfU8yytGyW7SuuvFciwUpt0QsF7ZQN54kHT
         7DuQLrmdv1QMVb6ZFYZIJhQURnKgZgryW5gewU1SUVw7YnOVAkiCeu3u9MTSJPs3iEhS
         8tGYkZCaoANGI/uiXZcpAFrREsHT9VzGXhBBYXGgeRZ7YukpitJa3Et0eF7bSxzbtzid
         Fe1ZdXnj76B6k8iswclbpxDlw+bK5p0s0QfhTK3Zbff7GPfVUlVCuU+cTnWhm5zQmMhX
         qm2g==
X-Forwarded-Encrypted: i=1; AJvYcCWnIOUAJ0AqQJk+USYE/VsBqkT3bVNGUOlcSYgHJHHZQmJT1yfSsh+S4vTSePDP6qykUVdTDAUtWdr2mQ8pjeFk/F6g8vsi4bwKuAcbXKEE
X-Gm-Message-State: AOJu0YyFK79uNk4hyAzmLA8OMopU8N0DfMQRLQofrJudWp9TP69TQ0tk
	+G0SmvhE7BVVRVz7o4bpd37KgFjJDd33Npj9cMoPkIai+5pk4Vnq6aAt+flc1Ok=
X-Google-Smtp-Source: AGHT+IGiQ+Tmiu5bRgdWvEF5qWEJRLGyLG8pqr96rQC5WW+Azb9B81qMu6p9UUbdzuVdRqrgE+JkBg==
X-Received: by 2002:adf:ed01:0:b0:368:68d3:32b3 with SMTP id ffacd0b85a97d-37194649a85mr4611119f8f.26.1723929453528;
        Sat, 17 Aug 2024 14:17:33 -0700 (PDT)
Received: from smtpclient.apple ([2001:a61:a92:ee01:29b1:1427:611b:84f2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37189897128sm6607098f8f.81.2024.08.17.14.17.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Aug 2024 14:17:33 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [PATCH] NFS/flexfiles: Replace one-element array with
 flexible-array member
From: Thorsten Blum <thorsten.blum@toblux.com>
In-Reply-To: <20690564a768f4c7e6ff9c3a7a520b9f36abef1d.camel@hammerspace.com>
Date: Sat, 17 Aug 2024 23:17:21 +0200
Cc: "kees@kernel.org" <kees@kernel.org>,
 "bcodding@redhat.com" <bcodding@redhat.com>,
 "anna@kernel.org" <anna@kernel.org>,
 "josef@toxicpanda.com" <josef@toxicpanda.com>,
 "jlayton@kernel.org" <jlayton@kernel.org>,
 "kolga@netapp.com" <kolga@netapp.com>,
 "gustavoars@kernel.org" <gustavoars@kernel.org>,
 "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <4CB2BE7E-5979-4424-A331-A5162190A102@toblux.com>
References: <20240817142022.68411-2-thorsten.blum@toblux.com>
 <20690564a768f4c7e6ff9c3a7a520b9f36abef1d.camel@hammerspace.com>
To: Trond Myklebust <trondmy@hammerspace.com>
X-Mailer: Apple Mail (2.3776.700.51)

On 17. Aug 2024, at 22:40, Trond Myklebust <trondmy@hammerspace.com> wrote:
> On Sat, 2024-08-17 at 16:20 +0200, Thorsten Blum wrote:
>> Replace the deprecated one-element array with a modern flexible-array
>> member in the struct nfs4_flexfile_layoutreturn_args.
>> 
>> Adjust the struct size accordingly.
>> 
>> There are no binary differences after this conversion.
>> 
>> Link: https://github.com/KSPP/linux/issues/79
>> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
>> ---
>> fs/nfs/flexfilelayout/flexfilelayout.c | 2 +-
>> fs/nfs/flexfilelayout/flexfilelayout.h | 2 +-
>> 2 files changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c
>> b/fs/nfs/flexfilelayout/flexfilelayout.c
>> index 39ba9f4208aa..fc698fa9aaea 100644
>> --- a/fs/nfs/flexfilelayout/flexfilelayout.c
>> +++ b/fs/nfs/flexfilelayout/flexfilelayout.c
>> @@ -2224,7 +2224,7 @@ ff_layout_prepare_layoutreturn(struct
>> nfs4_layoutreturn_args *args)
>>  struct nfs4_flexfile_layoutreturn_args *ff_args;
>>  struct nfs4_flexfile_layout *ff_layout =
>> FF_LAYOUT_FROM_HDR(args->layout);
>> 
>> - ff_args = kmalloc(sizeof(*ff_args), nfs_io_gfp_mask());
>> + ff_args = kmalloc(struct_size(ff_args, pages, 1),
>> nfs_io_gfp_mask());
>>  if (!ff_args)
>>  goto out_nomem;
>>  ff_args->pages[0] = alloc_page(nfs_io_gfp_mask());
>> diff --git a/fs/nfs/flexfilelayout/flexfilelayout.h
>> b/fs/nfs/flexfilelayout/flexfilelayout.h
>> index f84b3fb0dddd..a269753f9a46 100644
>> --- a/fs/nfs/flexfilelayout/flexfilelayout.h
>> +++ b/fs/nfs/flexfilelayout/flexfilelayout.h
>> @@ -115,7 +115,7 @@ struct nfs4_flexfile_layoutreturn_args {
>>  struct nfs42_layoutstat_devinfo
>> devinfo[FF_LAYOUTSTATS_MAXDEV];
>>  unsigned int num_errors;
>>  unsigned int num_dev;
>> - struct page *pages[1];
>> + struct page *pages[];
>> };
>> 
>> static inline struct nfs4_flexfile_layout *
> 
> NACK. There is no advantage to using a flexible array here. Indeed,
> you're replacing something that is correctly dimensioned (we only ever
> use 1 page), and that can be easily bounds checked by the compiler with
> something that has neither property.

I see. Why is it an array then and not just a pointer to a struct?

Thanks,
Thorsten
