Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1A923D7EA
	for <linux-hardening@vger.kernel.org>; Tue, 30 Sep 2025 17:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759252172; cv=none; b=cnh4Rx4HWZHlOyPHdxApKwdurxIxZt/MVnmhWvlQpuCQGXtVvJalZz88L3MHWUCaQ4ZZE/v9NM8IggLcDFFxiec6XKbsPpyXdMZZh1swsSGqihp6BmPdbc5BBYaMNkZJUEkktSeoSB0q23PLOdmkbmVt3zIO9gRAyKfRLhNXZOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759252172; c=relaxed/simple;
	bh=a5QytPqWgentrmnvqjs47PAKB9egMdTsoLZhe4hRorg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sbzMHI1OwQ0ZRLi5Bv1TELF3TGlOLJun5LuQPl8Y1EuvUT0VKh7H+xa+UwsYDsAboyR2yNROLtzLZbXc/LByFkJrHsN03d9UU8TcpL1h/TbwNDIGrjlLGdcKuEcbXKCRAg+66kgwNh2Mpuw4NdrQvYM6Fl6hhCRnV8hO4wSz1f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A76/eGQX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A76/eGQX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB338C4CEF0;
	Tue, 30 Sep 2025 17:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759252170;
	bh=a5QytPqWgentrmnvqjs47PAKB9egMdTsoLZhe4hRorg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A76/eGQXCUqEY3JI3FeVhjg6WnNF9uNp0YXScjs2Xnth8yoiBwXMPsGM77tMy/V8l
	 EM95+w3pX+0spkAtcZI0TMtHtb7GPL6SsZoMSD4j3bOSWc0wk1uKNDFV0HWBODe2/c
	 aTqktZKkstHkKKVFF+2v0gtsysrtwqcbIIMgOLTDDAUiMzMV3E4jdXPhnRkWC3mJA3
	 WxU1sNjy8G89j6gUFPXu4bvHtsLbVWEOzwH/pwhvsq7jTNtlO1kNEu7GEPywEtkJ9C
	 De6/fY7ABbJVulZN52T9/4Go6NH9Xac7VWODI0p30zezxVhpcELXz5xpEVMGJbOEuE
	 f2TBq6G0YpzqA==
Date: Tue, 30 Sep 2025 10:09:30 -0700
From: Kees Cook <kees@kernel.org>
To: Claudiu Zissulescu <claziss@gmail.com>
Cc: Qing Zhao <qing.zhao@oracle.com>, gcc-patches@gcc.gnu.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] arc: Add const attribute support for mathematical ARC
 builtins
Message-ID: <202509301008.44422F06@keescook>
References: <20250826042212.work.202-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826042212.work.202-kees@kernel.org>

On Mon, Aug 25, 2025 at 09:22:17PM -0700, Kees Cook wrote:
> Extend the ARC builtin infrastructure to support function attributes
> and mark the appropriate mathematical builtins as const:

Hello again. Is someone able to review and commit this change please?

Thanks!

-Kees

-- 
Kees Cook
