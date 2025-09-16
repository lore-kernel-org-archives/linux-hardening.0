Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9372C158F
	for <linux-hardening@vger.kernel.org>; Tue, 16 Sep 2025 11:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758021697; cv=none; b=q+Z1OHP1L38kPYpt5xu4xk1fB1MA5NUVw//fObXQPK/Xo0GzLntOrKCQRAWM3FS65r5Z/3QKCdCuf1ZNp6LeLbasO4OAfYEYVERoLLHJbqtVsKIUo0el02awYYbyLup8lFpyvnNYa7hmDSqY6fdsl4D1eATbDYWizcoaeHte1S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758021697; c=relaxed/simple;
	bh=PT6RSjPR6nsTnNS42majHjNEe7o+uTu6M+72v8l3iSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CrJ1yjlGIu5GX9uxGPgcQT0hT8feED29RU7X5CQGIBqSqpqPHJJPc192hZxw58g+lRZNYNC/JwkmV5MKCt/68P8j8PtR7vsXuyFCqYTZRyj3VP27swykGOYU1/Gehww8eUvpfAEYP3MZs7QWsqoodTIFavqBzztKcw+Vmyo6IZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ggSv8Srp; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ggSv8Srp"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-62ec5f750f7so9366238a12.3
        for <linux-hardening@vger.kernel.org>; Tue, 16 Sep 2025 04:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758021693; x=1758626493; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uea5mfPfz6gsP2PTuhVLwd3VedG7XAMEGNBdCWZOsHw=;
        b=ggSv8SrpUu3/G6YUa1wCB3eOnf6vlEV4WeAX8168zTXT1c5RrkysFb61x/IVrZ2ioB
         ksyyTs+pgvPE4v66yYHmsbhT6Sxfdc1/foredqRYf5rN2sLyqg+cjFpSL3lFP5QwrThR
         sH88ZjERmT9cJp+uPskNrTd5fJhxe5ChuHeJBqmGGytfpCfeHYAoBj2z/d5gMcePUxkl
         OYNAxJO+u3Xe+yz4IuafMXvwLdPaT0FB6HMVuHUcmtY5Vy5V5R7bPexqmPPu9Zmaozrd
         DHWcJ+rZfSxQtX8rvX0pPWk/uLtGYPvyuCp5+OGndrFzBgkWiBbkLSNncnh/la0oseLx
         DuUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758021693; x=1758626493;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uea5mfPfz6gsP2PTuhVLwd3VedG7XAMEGNBdCWZOsHw=;
        b=FMICyKX7S20bK/xsUW7N/u6pOw9oyURWtHSGUk/f269zDYwdmFnMM/x7hjQaY56syN
         8e4ozpSKYfKXXUtFYzQZsqMGuj6NwXhuL+XZ4Z+hek/4m9/+jsTCetxGpCxm/DhF0ORq
         uvB82RnDSKOtbq0Vt+meJK3e63FiZcw1qTLJc8Il1slQjLgkjoKqFtHhTqxiGa3huegN
         li8H0UcIK5eT6pn5iCjHZfFRW10sYwfE0qCMKUq/dWT1U5q7XT9mB19hHhgGfGfp+G4Y
         tT7JGkShheEHNMa8Gbv2aXoNlow7u+03lWm/J3/JgUEA86c/IFoFryqnM1buIFlOhxXy
         ef0A==
X-Forwarded-Encrypted: i=1; AJvYcCUZAcLc600m4HDknTpBA6sCEGJKoAvYmCy1vO1U9p/GTAxP3uPU1xBcIkKwfYOP2h97me3pBBq9t3I7nZXE09M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6U0o9K6rK9WaHsl7VEFHxiOm9+eeFIkl2nGRBFlrydbw/Y/cg
	5GuxoNP+QUku+kfrM3TUWOwtW/Bp3Q6f6Z6ORCg+stfRW0ULfa9kczyaiCuhXjrmIkY=
X-Gm-Gg: ASbGncvmFwFJdibHtie7vbEYNOkWe7PrfGs/EPZGx6bKfNd709/dw1PqCVNmlQl8zPO
	QJwXx+e8vXT3lJ+33gBbnCqaEb4IKpCaAWJjHABM/1jClfZKQQe7CzKbDv7VsKDDGCgcTas+7nY
	zQoAcsXjknfuu5YbA6JjywLThHyH8mhDpT/gE3hUzAdvYEfFACZBD3sNjBpNvkmGl1MfB7e3yjN
	CzRkqWEsy/p8CbbRLOoWX6WuFbfb8+xPakuY+9nSyiFELb0MgrqgisDqiaDA44umqvYs4HpIkDK
	RNEtk6PGhWEI/00/Pmi+1hib567sM4Vs+S22HxVAmtHMZzhOaLNeQrsHgfXTqzn0kH3DKcLLdfG
	ozFuHozNAy+MTRCdbsqe4C5KVm038CpZxbPzvlbdx
X-Google-Smtp-Source: AGHT+IGdaApH84qgSh4FpIAmIv68lRlYszt1DGU1HPMtQq+Jg7ayFfDUxA0h2cZACJ5agdILmluAcw==
X-Received: by 2002:a17:907:6d22:b0:b0c:5929:4cff with SMTP id a640c23a62f3a-b0c59295025mr1006070266b.26.1758021692577;
        Tue, 16 Sep 2025 04:21:32 -0700 (PDT)
Received: from pathway.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32f21a2sm1156991066b.83.2025.09.16.04.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 04:21:32 -0700 (PDT)
Date: Tue, 16 Sep 2025 13:21:30 +0200
From: Petr Mladek <pmladek@suse.com>
To: Jinchao Wang <wangjinchao600@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
	Yury Norov <yury.norov@gmail.com>,
	Qianqiang Liu <qianqiang.liu@163.com>,
	Simona Vetter <simona@ffwll.ch>, Helge Deller <deller@gmx.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
	Shixiong Ou <oushixiong@kylinos.cn>,
	Zsolt Kajtar <soci@c64.rulez.org>, Ingo Molnar <mingo@kernel.org>,
	Nam Cao <namcao@linutronix.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Joel Granados <joel.granados@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Sohil Mehta <sohil.mehta@intel.com>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Sravan Kumar Gundu <sravankumarlpu@gmail.com>,
	Douglas Anderson <dianders@chromium.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Max Kellermann <max.kellermann@ionos.com>,
	Yunhui Cui <cuiyunhui@bytedance.com>, Tejun Heo <tj@kernel.org>,
	Luo Gengkun <luogengkun@huaweicloud.com>,
	Li Huafei <lihuafei1@huawei.com>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Yicong Yang <yangyicong@hisilicon.com>, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org, kexec@lists.infradead.org,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/9] printk/nbcon: use panic_on_this_cpu() helper
Message-ID: <aMlIOt52xnLIvOpK@pathway.suse.cz>
References: <20250825022947.1596226-1-wangjinchao600@gmail.com>
 <20250825022947.1596226-7-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825022947.1596226-7-wangjinchao600@gmail.com>

On Mon 2025-08-25 10:29:34, Jinchao Wang wrote:
> nbcon_context_try_acquire() compared panic_cpu directly with
> smp_processor_id().  This open-coded check is now provided by
> panic_on_this_cpu().
> 
> Switch to panic_on_this_cpu() to simplify the code and improve readability.
> 

> Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>

It looks good to me:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
