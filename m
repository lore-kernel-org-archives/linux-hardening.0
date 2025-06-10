Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731A721FF57
	for <linux-hardening@vger.kernel.org>; Tue, 10 Jun 2025 08:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749544570; cv=none; b=GwicDPrmX2qnjlHK4/smWXPaAyliwHDXvgPHzKMziqeLAIIOdYus9lp7c5mt+vA17SvyZPGVIOSlDSWQBPWWo61QNz1HQJ4C/I/f95cvQIZqpUKjra6pjgstZ+jsY8wwfGkp0isoFsf/FxxLI5WTvuLbZKxkr3s3OnwZVFQC7Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749544570; c=relaxed/simple;
	bh=ZQz1tLG7kcWUwenzY9ZEbwsbyY9z1eYvjc4bgBPpWjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cm2F/6VfddY3HQu0C2oN9YSmXgOtgNt19TZEngM0eINTkgGJOF50ED6uNx4KsFmtYMKU77hUKJN96/UNK8r7F/V0MuFm1s3PxixkRYA8M5q4PYs2icZYyjgu2U8QeKvo9hwWqfhtYk4NAitDWuMVrwIpDnvN7SaiTW00HhQinLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OsXU/5uQ; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OsXU/5uQ"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a376ba6f08so2874263f8f.1
        for <linux-hardening@vger.kernel.org>; Tue, 10 Jun 2025 01:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1749544567; x=1750149367; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nDL1VH2zgeGps6X0Zhyb1MxJka1vOhvb2PWMkFIaGrM=;
        b=OsXU/5uQyuKxZY9UMxQHOEtKqlcj4a/ExbFJyl/xr9uRf6FADU/UN5z4IRG67FfyGL
         JhrpGRUzYeV8C1fnoJp08DkKIyjuotao3ZkS5IRStxZXw8YuNRBocCqpa01mxgDktg5o
         Qpo28Qmap/V+UqLOFZGh0G3/pSS/8dJgfmkEt9w5cTqyPZxF7j6N49AuJ2RCn5Dws08r
         6BvV+EWDF4T3S6oED2WmlXAoNWk4a9UlnND9mBLwDWbzMx1lLKN7jWADvCKxtc+vaECW
         ci/jzg1r0fnTIDjHRoC59/OubN6rAv2FEzt4Tj2Vz8hmP9gFeks6r64WG8/0PMGOMHHv
         ksTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749544567; x=1750149367;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nDL1VH2zgeGps6X0Zhyb1MxJka1vOhvb2PWMkFIaGrM=;
        b=oue67nRdvhI02JrZQxK8THMSGad/EPbyqY2E64zisUJCwgoai5KomN8wN070MhskTV
         PpPEjQ+pNM2F/v5kH82TtIhkSUqgDj+fgXnprbIv1Om57EcN8rdPDGFV6nz1U5fv/eCR
         zKqR8sojqPiR1NZT5nTAkQIaWNVj8QM27TXpELqZpUWAew+Lj9UsWPWMUvA0ANrVDcmj
         Fkjqjb65hlFf2vu/pdhjzZ2cp8NtpCnbI99TmSptgp0NJwcxCd9K7uJY/IDtR2dbr8hy
         hTZThtxdIRdc/5Weee18EhXBbgRGPpkr1ojQM12qLBUTP1kUkYMBWX7GqN2i+D9lgVGQ
         qNxg==
X-Forwarded-Encrypted: i=1; AJvYcCUvzXEBEb4OX3QWLk4YoJqqqb1pyJ48uXuPQrGC/FnqMMu0Y3LaJMOmW3dbF8KSi8Gf38nZzFTj+iwH8nQFQl8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3t1bQ8s+iBqg50JHi2iJHO7mCHDBCCYzETYtz5gUiCWlrUzos
	RJc+VL2uBarAstBETELzMnlZorHxXwdZVgviEoan3Iw2be9G4CvImt9Zf/5IsWNvLnM=
X-Gm-Gg: ASbGncsbvcLYhz/NRsPzIaL8O77X75HTBFHq5uXkLWVaESo/VC8yDLe9mj//Bph1HpG
	oHbKUz/N5+Z+5JRnIx246oapWvVGc1Lud10a8v/Q5pQ5SzJoJ6EqDwvgvt7Yghdp5OgeKlgTAvO
	eh6z/FqmJAw8UZyzglvf/txQFkKjumAYu50/coZ1Zq4HxmnUlnDzY5lr+ypj6ayuAab7ojF9S8t
	FOkOvwEZiXu3LoN3jlTaq4MkOYX8pJJ1ehpnyojGfKg3yMxFh5GEwl6jSWXMFSK+npG8LyG5r0z
	ub9HTpRYF4pQ7EhsYGFviGVuxuTpkOFwdx13nOqeRoLd278kTQREGINYxHxvwS/1
X-Google-Smtp-Source: AGHT+IE/nI85vSWlttVj+F3DLQC1penmgc3tIfP/1EOoFPr6y0TcG5WWvzoq1ne1V9qLxIrFBkrV9A==
X-Received: by 2002:a05:6000:40c9:b0:3a4:f6ba:51da with SMTP id ffacd0b85a97d-3a531786845mr13169150f8f.15.1749544566711;
        Tue, 10 Jun 2025 01:36:06 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482af38386sm7001718b3a.6.2025.06.10.01.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 01:36:05 -0700 (PDT)
Date: Tue, 10 Jun 2025 10:35:34 +0200
From: Petr Mladek <pmladek@suse.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Kees Cook <kees@kernel.org>,
	Sergio Perez Gonzalez <sperezglz@gmail.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	David Rientjes <rientjes@google.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Steven Rostedt <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Tamir Duberstein <tamird@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
	linux-doc@vger.kernel.org, linux-mm@kvack.org,
	Thomas Huth <thuth@redhat.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Stephen Boyd <swboyd@chromium.org>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] slab: Decouple slab_debug and no_hash_pointers
Message-ID: <aEfuVgR78G1YgRau@pathway.suse.cz>
References: <20250415170232.it.467-kees@kernel.org>
 <Z_-dPcdiGW0fo8Ji@pathway.suse.cz>
 <202506051314.D6EDFA91D@keescook>
 <aEbyHeG8qh8GChTh@pathway.suse.cz>
 <202506090823.33ED63C@keescook>
 <aEdANsGsQHqVQ9Wy@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEdANsGsQHqVQ9Wy@smile.fi.intel.com>

On Mon 2025-06-09 23:12:38, Andy Shevchenko wrote:
> On Mon, Jun 09, 2025 at 08:24:47AM -0700, Kees Cook wrote:
> > On Mon, Jun 09, 2025 at 04:39:25PM +0200, Petr Mladek wrote:
> 
> ...
> 
> > As long as it's in -next and scheduled to land, I'm happy. I'd always
> > like it earlier, but the less workflow disruption the better! :)
> 
> Hmm... The __diag patch series were in Linux Next for a few weeks and did not
> land in v6.16-rc1. Just saying that there is always chance to go into cracks.

Urgh, I am terribly sorry for this. I forgot to do it the other
week. And I missed it in the merge window because it was in for-6.15*
branch. I had a feeling that I have forgot something but I did
not find it.

OK, I guess that I am getting older or going through some more
distracting times. And have to update my process.

I have just created a list of branches which I have to merge
for 6.17. I hope that it will do the trick.

Best Regards,
Petr
