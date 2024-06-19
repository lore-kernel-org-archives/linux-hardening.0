Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B666615957E;
	Wed, 19 Jun 2024 20:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718829227; cv=none; b=oD0NG3gz+otuxsgRFnBE0pDHJKOySAMogtAdgFtJyAB2Vy96eZcg0cwIPLRnJ3tzg1kARBOLmsXbdnixlnsgkdAJnxK1JnW+v/DPY+0/w+Uj29WN/d0FvLAOGVOl+SUwkLD4qdzXUb3J+MFNXktxvYp/38meNz00wLEi7h16PwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718829227; c=relaxed/simple;
	bh=A9YG6zdoG6OhIJEF6xhsUKbyevzLbK8n6MsvXyF0UXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i0phGnrffmosGjHNg3Oy+2sl2MIpOd4Sf40HI9PjjXSvi6UurXJ/gpWkVT8Um3ZW7+qGRRxLSir+Gr32thuUXc5Migf/lZYIeHl+3OEsi4gIjbdhHQgk16EUVfr+s/rxMbjiUMYUR9zEl1DojJJnPICznfHzj100ZYykikmXzNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fssoeO+1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fssoeO+1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30545C4AF0D;
	Wed, 19 Jun 2024 20:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718829227;
	bh=A9YG6zdoG6OhIJEF6xhsUKbyevzLbK8n6MsvXyF0UXg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fssoeO+19Y54YLTNplhEXZf2pZa/gB7O446sDI6wxRz1d2rEaBNDzVe9KTcz0VLal
	 dwt8Tht/Zee+1Vfg3xqLhxQfxY1icFgUTaqZSV5GH2/RGlTeth8csXN/pDnX6PnLA5
	 r/RPFv82snUdX6Etejb6bJjfGi+Dh4iBucD8Wfc4u052ZkIC02NCMEg8AdLRhuLbLG
	 Qk/zaKN5KEOH1p3I6ryfDmP4NCScB5tICvOHBf+Q3hW87fX2K8mUraQ5KaXZqKJhBc
	 2s1D9b5R2YRXEcw8eVbqSLbCkla6TcWnLB1tcuHBcC2ClDec355cBVCsobjCHvSHuq
	 ILf2tO2eTwqUQ==
Date: Wed, 19 Jun 2024 13:33:46 -0700
From: Kees Cook <kees@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Johan Hovold <johan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH v2 2/2] USB: serial: garmin_gps: use struct_size to
 allocate pkt
Message-ID: <202406191333.97D01EB@keescook>
References: <20240619-garmin_gps_counted_by-v2-0-f82f10ebbf28@gmail.com>
 <20240619-garmin_gps_counted_by-v2-2-f82f10ebbf28@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619-garmin_gps_counted_by-v2-2-f82f10ebbf28@gmail.com>

On Wed, Jun 19, 2024 at 09:42:45PM +0200, Javier Carrasco wrote:
> Use the struct_size macro to calculate the size of the pkt, which
> includes a trailing flexible array.
> 
> Suggested-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook
