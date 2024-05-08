Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500DA376;
	Wed,  8 May 2024 00:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715127044; cv=none; b=oglVU0Y/tA9er7h2uj78sYCHm7pWMX5i/sU83LQJUgID7kDXTfJcmqKe4AX6mOl7PEq7NLmVlLzvzJQHEsx2nBbwSJdx2wRGZPHf4hDCaX8ZSV578jpHgEjj66guVw1murKePJ3Ditseg/qcrcg/BP+xO4SxdU+klCT7YkOw2Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715127044; c=relaxed/simple;
	bh=YYimxk82ybgdi1fUKmFUwfYtpSzOpBoq9hOWGpuXEr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Crjg9Yx5dggIVmvp7zU5icS3UOWs5FE18B+KmKpcgvBzQ31beeM5oDm7JFLYyIUDeR8Xb9+oboB9Lmfpy54k1oJqWYN2bt9Z4QyzdEhhQL1rb3lRC0JPjE9U7Cnlm1Y+ceVTszJuJtib5l+Ym9kfS8/vsOIYFCsACMJZE70Xe0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=pVlA17cb; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="pVlA17cb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=eM7u39jxMuwtzxSxV3ofyR5Os8gM00ob3zb2+NEoLvU=; b=pVlA17cbEXQXUJwfmziJdT/pzM
	OfvTIlrmq/sxNGUcQuVO5kngSZNediU1l30Iz4V0eEWL9oiaQQzHHHEHLS+iWpOdXvkRnBIoVuikF
	+kM1B+jOLuCSyIHRRLMRRpNNvqUwdLouvNnU1+CRMzTw7xYJ6Atomp9CSWRdGspXa/krpKRbTIECh
	gTisO5xwE9vthNlSwD4ufpaM9ctzsYdipXHzPAO/JSGfPPOQmlWDc/ModfFEuiplMRxxCf8vL+7yz
	AV7pjKGwICxqJvR+muJl+fql2iFIESjrxr0r19qURGS6wZ9Uy79yApnNVRN6Q4B12wwL0RpBllmNe
	6ajaUlbA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s4UtH-00Fa9R-27;
	Wed, 08 May 2024 00:10:35 +0000
Date: Wed, 8 May 2024 01:10:35 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Justin Stitt <justinstitt@google.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Nathan Chancellor <nathan@kernel.org>,
	Bill Wendling <morbo@google.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] fs: remove accidental overflow during wraparound check
Message-ID: <20240508001035.GK2118490@ZenIV>
References: <20240507-b4-sio-vfs_fallocate-v1-1-322f84b97ad5@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507-b4-sio-vfs_fallocate-v1-1-322f84b97ad5@google.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, May 07, 2024 at 11:17:57PM +0000, Justin Stitt wrote:

> I wonder, though, why isn't loff_t an unsigned type?

Consider
	lseek(fd, -10, SEEK_CUR)

PS: the above is *not* an endorsement of the proposed patch or
KASAN overflow nonsense in general.
