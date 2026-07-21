Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F69833120E;
	Tue, 21 Jul 2026 05:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784612807; cv=none; b=NSGMrzhNYp5Hgdd/v/zFV9L7aasjU/t2izQssuDijK0tOvYAbbEo0nWAyHKfYkt1VTIBo7Y4dI/VsY0njZI3a15emSwebgt7fKncJNqD0VjsRybSHY0Dn/82SwgU0XZkLR+WDHUGOVRV3mqboZcYOjBT7uXjye4rQz1D15DgLkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784612807; c=relaxed/simple;
	bh=xCM8Ic0nGGdil40qg5+ZMfSMnwKzU2PWyUYFdFriCg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fnkDJgdrXzQjfaH1TBI4MsjLxISTKV6EFfU4jHBJSc37zRC3Acebs/gLVMI7kZpTcTOiRl+EYzfK0VxZ5iiflbSyV6IKCX2/9tIH4OWeHEqcpICTNjpNS2cb/1NYOvUcFbSZeYBkj/H9COrVxGpHH9imtl3voObfv/gJO0qC/nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MT34rlqn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MT34rlqn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FC611F000E9;
	Tue, 21 Jul 2026 05:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784612805;
	bh=xCM8Ic0nGGdil40qg5+ZMfSMnwKzU2PWyUYFdFriCg8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MT34rlqnYE5/Zgzwdj7WVhAEWFJbnXVZVxTlwy5vTrIcAWXYXwM+RFzKwFhTLgi7W
	 CCuGqrfH2U9cF3ALyq3S7sN3dBSoHuDuQEigTZPBGfTSbl2/NCW68k19IZfozf4dIK
	 6AeD5OUfRRKSbJZYaTl0ITE9vUgRLDLK+tMvx850=
Date: Tue, 21 Jul 2026 07:45:22 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: York Jasper Niebuhr <yjn@yjn-systems.com>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	kees@kernel.org, franzen@sec.in.tum.de, ardb@kernel.org
Subject: Re: [RFC v3 1/5] Pinpoint plugin
Message-ID: <2026072107-scrabble-lagging-82ab@gregkh>
References: <20260720191146.21473-1-yjn@yjn-systems.com>
 <20260720191243.21571-1-yjn@yjn-systems.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720191243.21571-1-yjn@yjn-systems.com>

On Mon, Jul 20, 2026 at 09:12:43PM +0200, York Jasper Niebuhr wrote:
> Signed-off-by: York Jasper Niebuhr <yjn@yjn-systems.com>
> ---

We can't take patches without any changelog text :(
