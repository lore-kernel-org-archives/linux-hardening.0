Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED76211A0A;
	Tue,  4 Feb 2025 18:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738693061; cv=none; b=u7wVz/LqU8BUMbmEKIPl7w9lrEuzSe3qMz2zRpW5NfFBKemOjxp7ZURm+Duj2lwGiiyhbJa/KeVEeGgCsKkDClBlu1CzdHfnzwbDkA9zw+ANmi8jiuMZnfB2mt4k8P6eFc2XlqHexoM+OIq8Ln+zFuMdFMwUql/E+GNJSTZIoMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738693061; c=relaxed/simple;
	bh=22HW7+XMxKFHo+/mgAG8vFkQ7pc97tPqNxUhKaWnrMY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=srTgDyv+oABul/pvTCuDtvy4E2WeeJieEKDK2QbqinFk13NqPRES+7rHHpVVjPdrIpkGgeEbYnWIIKYkgsERPp8Iz/F4IWAxyorJLfSHs1D3dSCEmJekuw9UukKlkGQOTjnUwoYSegT1XOMi5jngw1EcrMz535WPhab6a0a9WLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ceYszPlh; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ceYszPlh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=22HW7+XMxKFHo+/mgAG8vFkQ7pc97tPqNxUhKaWnrMY=;
	t=1738693059; x=1739902659; b=ceYszPlhqkMuxN6NllJDVHMbEZMkTQzz4xgOCf6P/ALyoMl
	ecg9njnF44ujllqJ4zKU96uxR8Vyd4b8RDOob+HHRpzHMZwFJ/tY8rfB4rebrIf1WD7z1d9ryDFJh
	wG1BOxXvOXuW8XRTpufHctvTY+GRVaP1SnQdnXbEIp6Eue1A8ECkSoYYz/1sHY49yaREN4aLv5An0
	X/Du2yvlDSrLRA6f5DpVg0Id6trR7R3X5BckuDPI6jqNxFYhWm/NeKk6sfpnrUbGTWeGfjAk+alyp
	gtb+TsOAEHDxEQnwUoEYLaDBsWGIn/ppxwfOApyHgKIp/Ggjr1TakTy5Sajl6+9w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tfNUH-00000002sDY-46kF;
	Tue, 04 Feb 2025 19:17:30 +0100
Message-ID: <553df4d7ddadb0580a2c35fcf8d5b8c3aca69449.camel@sipsolutions.net>
Subject: Re: [PATCH v4 1/1] exec: seal system mappings
From: Johannes Berg <johannes@sipsolutions.net>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Kees Cook
 <kees@kernel.org>, 	jeffxu@chromium.org, akpm@linux-foundation.org,
 keescook@chromium.org, 	jannh@google.com, torvalds@linux-foundation.org,
 adhemerval.zanella@linaro.org, 	oleg@redhat.com,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-mm@kvack.org, jorgelo@chromium.org, sroettger@google.com,
 ojeda@kernel.org, 	adobriyan@gmail.com, anna-maria@linutronix.de,
 mark.rutland@arm.com, 	linus.walleij@linaro.org, Jason@zx2c4.com,
 deller@gmx.de, rdunlap@infradead.org, 	davem@davemloft.net, hch@lst.de,
 peterx@redhat.com, hca@linux.ibm.com, 	f.fainelli@gmail.com,
 gerg@kernel.org, dave.hansen@linux.intel.com, 	mingo@kernel.org,
 ardb@kernel.org, mhocko@suse.com, 42.hyeyoo@gmail.com, 
	peterz@infradead.org, ardb@google.com, enh@google.com, rientjes@google.com,
 	groeck@chromium.org, mpe@ellerman.id.au, Vlastimil Babka <vbabka@suse.cz>,
  Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrei Vagin
 <avagin@gmail.com>, Dmitry Safonov <0x7f454c46@gmail.com>,  Mike Rapoport
 <mike.rapoport@gmail.com>, Alexander Mikhalitsyn
 <aleksandr.mikhalitsyn@canonical.com>
Date: Tue, 04 Feb 2025 19:17:28 +0100
In-Reply-To: <htdv44tqzi4jl2b7dwutsdwnh4tgrxq6xdvumi5wwu3hnh7sgw@tfwlal74ukx6>
References: <20241125202021.3684919-1-jeffxu@google.com>
	 <20241125202021.3684919-2-jeffxu@google.com>
	 <202412171248.409B10D@keescook>
	 <htdv44tqzi4jl2b7dwutsdwnh4tgrxq6xdvumi5wwu3hnh7sgw@tfwlal74ukx6>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2025-01-03 at 15:48 -0500, Liam R. Howlett wrote:
>=20
> So we have at least two userspace uses that this will breaks: checkpoint
> restore and now gVisor, but who knows what else?

I believe we previously pointed out it might also break running the
ARCH=3Dum kernel:

https://lore.kernel.org/all/2e5de601da34342d8eb0d8319dcf81ff213c7ef0.camel@=
sipsolutions.net/

johannes
