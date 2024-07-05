Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AF81487FE;
	Fri,  5 Jul 2024 12:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720181059; cv=none; b=c8kisZpNDRhKkiOHLOATB5eGN/LkVBh1noue5XsgE+FLaC7LRQDWYdPKNfG+7PZ1s9krkrEi1HA0fkMUx0ai6N21g8jpBwwgUbMTgCaB6m0tpdyziA2WAqRqrCXnXrNT2xUdgB4CHJzxsgD4anrGCZOokbJXovxtxE8h9le00pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720181059; c=relaxed/simple;
	bh=1oUR9Y0C1q+vdr3FNHCBM/69qcTQYNHIa5X5pQnwP20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d5CNEDrfBtrsjHjyreLWzLMXv6lAX75mSBlMTKbS+VmqwqdgbBoONPeiB6YBxD5a7A3uIfeHK6y7kZFkC5nxKrIW9s4Hf3e4A6IQ/364SyN4ptCKooxwlGKLoPO2iogX1Qv9mlmyABipk/8J4vrsSU5dZEfp8evt3oTQlcSPotA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N8KCx9+W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N8KCx9+W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3417DC116B1;
	Fri,  5 Jul 2024 12:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720181059;
	bh=1oUR9Y0C1q+vdr3FNHCBM/69qcTQYNHIa5X5pQnwP20=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N8KCx9+Wf1Y2ccoBaDCuzUe7bHZhyzChrmfBgJ9WoUkmGKnGBWTXfxT2Kogr3DWrb
	 bCA6dllwLH53jIQRJn+j9P21TBMJg8FVaFv5MKfxDcUWfpnJapTw0RGEc9XVNUEgN1
	 a7VZCEl7FmrYOY1fG/BbHcixlbFJz29YohawGP19e92YQNpel/S5VHkBnk71iJDxSa
	 qND0y9oeJZrrGlPImOIEmIMwLBM+rzzTRS3VDZrJM5s9VrAj5gGPxB3Jg1jClHAd7K
	 H5hrKTl2ZivEQ68TK6RQO3Y6aOExQNXfsRg4pE+x5R4VPVO453qbhh0AjqVbW2+g6D
	 CNNPyCSJIhKSw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1sPhfq-000000007PG-00h2;
	Fri, 05 Jul 2024 14:04:22 +0200
Date: Fri, 5 Jul 2024 14:04:21 +0200
From: Johan Hovold <johan@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH v2 0/2] USB: serial: garmin_gps: annotate struct
 garmin_packet with __counted_by
Message-ID: <ZofhReiVQ3k8IaFy@hovoldconsulting.com>
References: <20240619-garmin_gps_counted_by-v2-0-f82f10ebbf28@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619-garmin_gps_counted_by-v2-0-f82f10ebbf28@gmail.com>

On Wed, Jun 19, 2024 at 09:42:43PM +0200, Javier Carrasco wrote:
> The size is assigned before the first reference to the flexible array
> (see pkt_add()), which allows for a straightforward annotation without
> further modifications.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
> Changes in v2:
> - Use struct_size to calculate the size of pkt.
> - Link to v1: https://lore.kernel.org/r/20240619-garmin_gps_counted_by-v1-1-d8d816f085d9@gmail.com
> 
> ---
> Javier Carrasco (2):
>       USB: serial: garmin_gps: annotate struct garmin_packet with __counted_by
>       USB: serial: garmin_gps: use struct_size to allocate pkt

Now applied (after adding parentheses to struct_size() in the summary).

Johan
