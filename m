Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D728305E02;
	Fri, 31 Oct 2025 12:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761913481; cv=none; b=AHeWUx8rb+1mUJC2ofIA6sVmFnZaMxQeNjExZoJrgm2EfkId/jN6gyO1a3twR0+2TZXgHJ5B4oMYDWMjCbrY88P40EGBh3m7sNDM0hP1g20WpU/TIir4vQfxKbSyqh/qSDpagaTn99Ux2guyC3O9AS1ZXp+nXszGMLofrn0jIcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761913481; c=relaxed/simple;
	bh=D+liOL8V77CmYbYnVNyxcWsjyd8rfa/cOpDiCB/5Ag8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eyAKXYH2WImlu8wHEzko8D0C16JQi5mK/+5zwK31QdxmcNXcFlDUkEHTy/Q61HZRLp9VeuZ+i3gFO0njBY1Ejws1SYRKJdj1V2fn2n/gmgdPbRu/esWC5RIIHNgSliN3i9hXlBiKyi739e4RTnzh0fFDrNVQIdxgQ5G8q6ernTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xMssBfmU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xMssBfmU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ECC0C4CEE7;
	Fri, 31 Oct 2025 12:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761913480;
	bh=D+liOL8V77CmYbYnVNyxcWsjyd8rfa/cOpDiCB/5Ag8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xMssBfmUXAc2gNcyvrwo6s0HpqY2uvYHbzZ5GQK0ijl0M7wZUz4sthcG3WRaGcR5X
	 zYJLz+DEIqQHXasurJkaitXeKY2NNddp453z7YpAYCnFaf80UEtk7eW2EceDfhlGhH
	 YUeH9DJFNKk2QwO34OYw9yr2lh7lHCNkE6jX5Ang=
Date: Fri, 31 Oct 2025 13:24:37 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform: Replace deprecated strcpy in
 platform_device_alloc
Message-ID: <2025103140-plant-sprig-bdda@gregkh>
References: <20251031121858.156686-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031121858.156686-2-thorsten.blum@linux.dev>

On Fri, Oct 31, 2025 at 01:18:58PM +0100, Thorsten Blum wrote:
> First, use struct_size(), which provides additional compile-time checks
> for structures with flexible array members (e.g., __must_be_array()), to
> calculate the number of bytes to allocate for a new 'platform_object'.
> 
> Then, since we know the length of 'name' and that it is guaranteed to be
> NUL-terminated, replace the deprecated strcpy() with a simple memcpy().

This makes no sense.  You are saying we know the length, and we know it
is NULL terminated, so let's be complex and do a strlen() and memcpy()
instead of a normal strcpy().

Please no.  This is not ok at all.

greg k-h
