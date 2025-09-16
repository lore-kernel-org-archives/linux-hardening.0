Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB522D5C7A
	for <linux-hardening@vger.kernel.org>; Tue, 16 Sep 2025 11:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758021777; cv=none; b=mWuNWL1hVAyxhlbVpH54KEjjNcfn5lS39k3XF+2CBWzkfOT0q1S8WtKRBVFs3fH1rbL8wlpXpuqYwAO7WMMppfAvaBq0IlL531oGWO0S/xlOAZn1e8O4fRUgGQdmL8MnrjlUs83jM09Vnk8gkyxDz+7o3VSNL21Azg59DbJlgVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758021777; c=relaxed/simple;
	bh=8kc0CeLZLfeiMXrcTaHIH/R4jGNR3faf9TtHlR/N16I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oEMk9hhsg00zM1QgP4CXkHoJa7ljFeFpen1ixn1cr++jpKYGFENofgXheuicxuNgkLdludtfedjRc0LQGiqp0UjTFqYN1MLVPFd74k+lCj6b5rZmhRp09+SwYmF3ZQEHqyu8wuwA/eDC/M9dchS7Qm6ckMjAHUoopvMPPp/tWRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MX5mipFP; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MX5mipFP"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b04ba3de760so673400066b.0
        for <linux-hardening@vger.kernel.org>; Tue, 16 Sep 2025 04:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758021774; x=1758626574; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h0oabvOv3LnHYmSMEDkeEgkYTZEtABtHwxuQ+4V9AEw=;
        b=MX5mipFPNTEeqUz+RN5Bk3CNl2bgoRjnfeBCCnTpnZwFdVp2AUHOiZB5H0MhEXFS0p
         Dvt4wNOou4O/mbc4KNwTzf725/3AzR+10Z/Qcf1YHf3+GoDXPsZAA24cPXIGn1BIYv6Z
         t5/mSgVHEEDywFY1wbDcY3Hb1953rwYazW+fsPy0nB1lOL6BezBABOug+G5K9ac9xq7j
         /fThtfbNmg5zXKaDBBNNen2pvJpT40RlTjRPTnRG6O8o7Ff8JZIBYug8kwGktm9+/wR2
         Rx199khf/PS2JCs1L38dFm1F/xyMrobmsqVS3sk7iFpjrENvMRV/2jQcrd6aJ41jYpaM
         15jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758021774; x=1758626574;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h0oabvOv3LnHYmSMEDkeEgkYTZEtABtHwxuQ+4V9AEw=;
        b=KZrg05rMgZS/pxj9epybqQUQEpxfiUO6NiUgdZUOr3dA4ne2LINYa8sj77IOz93B+o
         N5m7idbROWEgMcxTK4IGQXeF92vhWO48IvbjLvpsvrVMHnyeeoPYvE9+jV+N8Wh64wm+
         YX/64vCeK3HhaRnBczbiZnRtIA6A9G98fqr7vUWOY+GqB2D2QG2cNACV5UfVcXnXEslA
         dyqc4e2ztnQ16F3ODBT+2r7i/X/efKAbNoYx59su7YQmkBqMnA3Bn5t8oPLQtNmeToU1
         RiF4Y+sr4QhFvcDT3GTG0DAiuVs8TFOA3naatQA4AJhDs+7sqdjnRnxtXSqfQksiX/rG
         xzPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWC/et7uZ7+Sc7wDsrS3ULHjqjfAJnQ4K1qf8/gyGPwvp2/oQlBP3KTnJpC0EfOOTiWnMCt6aZ2Xyju0HSaZt0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp7JdYAITCUYR/N7OhDJJUDgIQaU8nfbGZzRgt1awEug6clp4/
	pAyHdrYk7OhUIhRcVWcmjclOL68RjB1ZLs7ejwBK+qVSWcrupHP48nRW+p7zowkqzS8=
X-Gm-Gg: ASbGncscDaVxM9K9GCV+iUwkDAYtRj8+OkG9whbeCy7wg9S1mYCC7TgJ9uIYNQH3RPR
	7mr3n2a51SPep5fx+V9ueDVcxpN5fjGjlP3DcT/VmDzRNoFra5mT9e9LITPCH44UtixzrKMGZKz
	GIiL7IcI11emiM+lY7QhZpVfPYKWeIguHukbKKABC6rwaE2Vo3rhiq303JYCGvwQ+WZybxQIx++
	DGmjp7kfk2lrA6OjrcONUEhHzjJ66w8IckIRQJWzkOPiYZmR0TSSWgfjWj09+4RJdCG/8R7jyOX
	iQ+zIkGV7d8s3P5+OHAAmaQtj3trPKITm41VKVTpUEPFD3hpNEQPfCCyNESbe6IQ6FkFY6vjEOX
	xu73LpVp7PfRifUqm0HvQ2kOXxW26gUfCSza+DAoo2qiY53QVRK0=
X-Google-Smtp-Source: AGHT+IHgksZmCXWo+aWrU2puhznGEL5CDcY5xl+DcR6ldtoPz+TwMIqHuYXw60VG60pLkMPaI+rleg==
X-Received: by 2002:a17:907:daa:b0:afe:7027:56f9 with SMTP id a640c23a62f3a-b07c3574efemr1811450966b.17.1758021773565;
        Tue, 16 Sep 2025 04:22:53 -0700 (PDT)
Received: from pathway.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32f2098sm1157083666b.74.2025.09.16.04.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 04:22:53 -0700 (PDT)
Date: Tue, 16 Sep 2025 13:22:51 +0200
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
Subject: Re: [PATCH v2 7/9] panic/printk: replace this_cpu_in_panic() with
 panic_on_this_cpu()
Message-ID: <aMlIi9cT7xiYWo29@pathway.suse.cz>
References: <20250825022947.1596226-1-wangjinchao600@gmail.com>
 <20250825022947.1596226-8-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825022947.1596226-8-wangjinchao600@gmail.com>

On Mon 2025-08-25 10:29:35, Jinchao Wang wrote:
> The helper this_cpu_in_panic() duplicated logic already provided by
> panic_on_this_cpu().
> 
> Remove this_cpu_in_panic() and switch all users to panic_on_this_cpu().
> 
> This simplifies the code and avoids having two helpers for the same check.
> 
> Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>

It is great that the helper functions were consolidated and moved
from printk to panic code.

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
