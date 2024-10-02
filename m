Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CF11854;
	Wed,  2 Oct 2024 17:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727890385; cv=none; b=Klx4VwpOmFfWLJDQQx8cPiHRu82qgDtHJ+RBSZil0vylnzgXKwIk2y0x6/rePaFtiB0fdoIMu1Q/XDZ6kY7WyhyKirVdwCF4kvei7EJwYGmpyY6bcJd6V3Yo6IK9gFRh4P1pkezOHD2XvXqe10Ymfo72FOK8ZjJvNvYEOhinI6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727890385; c=relaxed/simple;
	bh=i7GRzl/3sSWdkBx9pufC2TJAg3hYOaw3cLkl6ZOXBFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BSYYxdYL9WlxcaoFRnfoJMqUdMp/+vB9Qwl6tVeRVHbxlbkGaG8pGjH1jAomIVimhV8bZ8es1bdVeu3ub5DvdHpjbsfXXe4BVylA1Yn7ccPyExUuD7YilUi46XbWbdiP4Xgu3lKZgxyXOTE8lYeD4MyyGo8XJJE5+eV+8hT/aBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=jYfSaEgl; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="jYfSaEgl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=V/R2GvgTvKCAcd3eeTKrMrkj7TbMYRQtWWjqtRw2w2U=; b=jYfSaEglLMsm0OYu
	LTkZupPCXvSqlDqyBJ+t43xzZkchklL7JVKdJbPvmWtDOep+KhRhmHtXgyMB3VJswjFEGS2w61Io7
	Vxait0b7wBb6gUMKplZprbTdMJZdxEyw8IN7D/eEd4M+u3hTaNCJHUMWBx+CtIBFMKGLvLkusNlQO
	vArlRZW1sUsk6xas3kNJsGSLUDxGJWTGMh0PEjmQgNwOmdCAqsmAtvpVGF/13JLoR3XP0d2h/pw9Y
	9C/jtYnfetttrDfohQWd2VfoI9l50xg5pkK1YC0eh/bIuppFTQFvC4RXwbPEfxLAM6UoJuBoUSmMo
	lgIKG8LowhnDvjJ3/A==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1sw3Df-008Vsp-19;
	Wed, 02 Oct 2024 17:32:59 +0000
Date: Wed, 2 Oct 2024 17:32:59 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andy Shevchenko <andy@kernel.org>, kees@kernel.org,
	akpm@linux-foundation.org, pmladek@suse.com,
	linux@rasmusvillemoes.dk, senozhatsky@chromium.org,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printf: Remove unused 'bprintf'
Message-ID: <Zv2Dy7RST8Q-pzL5@gallifrey>
References: <20241002012125.405368-1-linux@treblig.org>
 <Zv1Uk_3W2hu1M8-9@smile.fi.intel.com>
 <Zv1ZN8XZmSZTD-78@gallifrey>
 <20241002104807.42b4b64e@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20241002104807.42b4b64e@gandalf.local.home>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 17:32:00 up 147 days,  4:46,  1 user,  load average: 0.06, 0.02,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Steven Rostedt (rostedt@goodmis.org) wrote:
> On Wed, 2 Oct 2024 14:31:19 +0000
> "Dr. David Alan Gilbert" <linux@treblig.org> wrote:
> 
> > > I am not familiar with tricks in BPF or ftrace code where this actually might
> > > be implicitly called via a macro, but brief grep gives nothing that might point
> > > to that.  
> > 
> > I've got an all-yes build (well, most after I took out broken stuff) booting
> > with it, and it has CONFIG_BINARY_PRINTF=y and CONFIG_FTRACE=y .
> > 
> > trace_seq.c uses seq_buf_bprintf which uses bstr_printf rather than the plain
> > bprintf() that I've deleted.
> > Not sure where to dig in BPF, but I've had a fairly good grep around.
> 
> I believe it is safe to delete. It looks like bprintf() was added for
> completeness, where as everything is just using the vbin_printf() directly.
> bprintf() is nothing more than a wrapper around it in case someone wanted
> to use binary prints directly. But I'm not sure there's a good use case for
> it, as all users would likely need to add some code around it for
> processing (like trace.c does).
> 
> Send a v2 and I could take it for v6.13.

Thanks,

Just posted, message-id 20241002173147.210107-1-linux@treblig.org

Dave

> -- Steve
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
