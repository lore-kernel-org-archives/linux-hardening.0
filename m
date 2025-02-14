Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF0824503E;
	Fri, 14 Feb 2025 09:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739526862; cv=none; b=Zy27XQ0CbIUsGofPD3TovWm95jWI/FEGsEEhGP+NAx3Jq7w8gPgOreOX4IYvnH1M94x3up6Ozf0pdn9iix9goEojwhHqQZG1n6CwPGBkI1Bd+NVcxE3ETnGSs5qfU2XKu5clxDmRHfh+Rs8ZYV4RuAQCE3maEJGO5fG4fbXjZd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739526862; c=relaxed/simple;
	bh=C2xnOOK8duynixcfdCDbebd03W+WelpWQHQj6LDNHyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oto6O5UU27yulPzYSSj0liJ0UyHcXOMAY8/esYPeXbOlp7KQDRNGvCOZ35AWY8I5flFoaVPcJ3GArHbHXNSqOcEz9Ulr/vZqAEVtdx6qZpdb+EcKZQH20M60KmiLY9rt7zx42C6tCPvzAkL6G8ujMOUFnemz0T4zGhclEFT77IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Imo3C/Sk; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Imo3C/Sk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=C2xnOOK8duynixcfdCDbebd03W+WelpWQHQj6LDNHyg=; b=Imo3C/SkB/9e+GYQxujIZ1xjV3
	JI1Xu5XgBGRwDcogWEFQY1+4fJJJ6S1Mkev1BQaU97wCmLzY4PbnIgtFkc8oLqep4GeqrRJdJJwqu
	iQjREi6f+wtKxeh18XnwJ4eXUuWXwPlIB3wsQrU5I4VfbdMWbmH/kRSaMCcuPFxk/6O12iwe3bNu3
	iJ61cDVeb/pbL8IfIsymXyK5/0+GXDX5KebKgyxuhxQQPnKjbtb4AeNpZxc+E7P+19dg8dAMg4C90
	wjpFp2W9UM2enfW14aPI1SPq0sTm1xOg9rIq0lvudRewTJkryKSlP0q8EaZuSVYDa5gbSB5Te/FO1
	YFlPWNyA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tisOn-00000001Dtx-1zHc;
	Fri, 14 Feb 2025 09:54:17 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1114330050D; Fri, 14 Feb 2025 10:54:17 +0100 (CET)
Date: Fri, 14 Feb 2025 10:54:16 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: jannh@google.com, jmill@asu.edu, joao@overdrivepizza.com,
	kees@kernel.org, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org, luto@kernel.org,
	samitolvanen@google.com
Subject: Re: [RFC] Circumventing FineIBT Via Entrypoints
Message-ID: <20250214095416.GE21726@noisy.programming.kicks-ass.net>
References: <CAG48ez09JuZPt112nnE6N=hS6cfCLkT-iHUAmidQ-QGNGMVoBw@mail.gmail.com>
 <c46f5614-a82e-42fc-91eb-05e483a7df9c@citrix.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c46f5614-a82e-42fc-91eb-05e483a7df9c@citrix.com>

On Thu, Feb 13, 2025 at 01:31:30AM +0000, Andrew Cooper wrote:

> But, FRED support is slated for PantherLake/DiamondRapids which haven't
> shipped yet, so are no use to the problem right now.

FRED also fixes this IBT 'oopsie' IIRC.
