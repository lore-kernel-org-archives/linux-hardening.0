Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB6051D529;
	Fri,  4 Sep 2026 20:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788553463; cv=none; b=TEWoTrDLbPVFMlavgloyPtoCPsJI9KS/WBeEkzACvER+SK2PoXzUojbXysmjrf04aq0m1G9aiRYch3b98x7UqnP35usjYrouPWBDU/HqkGAmQ6FDbgWbTjVJNhBhc/UY0eCkfMI6GYa26W7iBd8yfcyPYhMFtoM2/9yTVl14G90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788553463; c=relaxed/simple;
	bh=ms2OdJrkMqkKKveo+Ime34AcqcpdfFYchCOEdRitn+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VXATOlAjY9tRY+9ZRr4DCUauYF2kHMmcKYb3TKNnUgmEG37cWYWdNeH8rCyz3WSfy+inhvPzLYiGY0qOBKQJ7nrDSgd+ZE3/PogCG2Akm+gGgGQxW05ZGV1iY5qDEWwXlfel2L7jJciCcYRxr438n4g/coXcc4GCsEbsWR8Ht/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YTBIj+1i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YTBIj+1i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 174F31F00A3D;
	Fri,  4 Sep 2026 20:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788553459;
	bh=TsAX4HCOLvsq6ZGLjASz71a4ftfgFtFFAa+rc6mhWP8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YTBIj+1iS5KE42SvYefI4ReN/Q2U8OYag9iEJRhFJmLBHy/hEJjUy2xBbYzDXvody
	 dvdibA3UDqvtyoiL4u4ELAzNAWPvxArL0350dnAhy+DCXCip3KsilLLe/yV4kwSk2E
	 VjvlZcZ6P11J+oqC23ZT0ul4XZO9aE4k9jeyv06YLnS33rRg8dvUWBpR9gUyegwHHO
	 9I5TmR9rO4wqDTZf0GWtE6WCvJ5sZwNC1dxp2gPCP2iUTv216u8JKZgYTpTp9IX4ya
	 SHZSkY29FhsDoZYil2Hp95cX7UqVzWoRxOobagYa297e8uhuCdOTJDhHp1AaxyKhbZ
	 gyw/0vgCD2t9Q==
Date: Fri, 4 Sep 2026 13:24:15 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Bill Wendling <morbo@google.com>
Cc: Kees Cook <kees@kernel.org>, Vincent Mailhol <mailhol@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/2] randstruct: report bad casts as warnings rather than
 notes
Message-ID: <20260904202415.GA2787252@ax162>
References: <20260903232428.i.323-kees@kernel.org>
 <20260903232438.60394-2-kees@kernel.org>
 <CAGG=3QUHtqFVCEcnxXO9fan_RBT_jjWtBbA8ECpQeiC1dKMnvg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGG=3QUHtqFVCEcnxXO9fan_RBT_jjWtBbA8ECpQeiC1dKMnvg@mail.gmail.com>

On Fri, Sep 04, 2026 at 11:14:19AM -0700, Bill Wendling wrote:
> Hi Kees,
> 
> On Thu, Sep 3, 2026 at 4:24 PM Kees Cook <kees@kernel.org> wrote:
> >
> > find_bad_casts() reports a cast between two randomized structure pointer
> > types with inform(), which renders as a "note:". It has done so since
> > the plugin was originally added, while using error() freely for attribute
> > misuse, UAPI structs, and version mismatches.
> >
> > Clang's implementation of the same check has always been stricter:
> > it rejects such a cast as a full error. There is no reason for the GCC
> > side to be effectively silent about the same problem.
> >
> > Build tested ARCH=x86_64 with CONFIG_RANDSTRUCT_FULL=y and GCC 14.2.0:
> > allmodconfig clean, and defconfig clean under three different random
> > seeds. A deliberate bad cast is still reported, now as a warning, at the
> > correct line and column.
> >
> > Signed-off-by: Kees Cook <kees@kernel.org>
> > ---
> >  scripts/gcc-plugins/randomize_layout_plugin.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/scripts/gcc-plugins/randomize_layout_plugin.c b/scripts/gcc-plugins/randomize_layout_plugin.c
> > index e2bd9ba08089..1e66f45fe29b 100644
> > --- a/scripts/gcc-plugins/randomize_layout_plugin.c
> > +++ b/scripts/gcc-plugins/randomize_layout_plugin.c
> > @@ -22,7 +22,7 @@
> >  #define ORIG_TYPE_NAME(node) \
> >         (TYPE_NAME(TYPE_MAIN_VARIANT(node)) != NULL_TREE ? ((const unsigned char *)IDENTIFIER_POINTER(TYPE_NAME(TYPE_MAIN_VARIANT(node)))) : (const unsigned char *)"anonymous")
> >
> > -#define INFORM(loc, msg, ...)  inform(loc, "randstruct: " msg, ##__VA_ARGS__)
> > +#define INFORM(loc, msg, ...)  warning_at(loc, 0, "randstruct: " msg, ##__VA_ARGS__)
> 
> Why not make this an error instead of a warning?

Yeah, it seems odd to mention that Clang's implementation has always
treated this as an error then not match its behavior. If this cannot be
made an error, I think the commit message should call out why.

-- 
Cheers,
Nathan
