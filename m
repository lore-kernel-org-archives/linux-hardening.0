Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794670123;
	b=w9sBBrK1gSbSsbm8mnbpaRpGgZ/BCpRghoZVsER5QQIZt1yTY4qUOlNT/rtzQL1iV0RD
	 GI6B3A1UtE0Lscj2+xtPLiGCiPoh+BDgjlDy5lPOjSylyJcWySpclu949D1MsU+PpJs0Z
	 iHs6C981HcKRkN81qe3h0BF/8XmBrZ+RnPf3ccj4WV8SGxC1Se1V+vvLxpQQU+62YO8UO
	 ZdkE6PYYYdtNNdy2pFdVI0L+DIQlkRtu+bxRUk1ydS8ywoLtJoDVBmNlVzdMr8/3Eihyj
	 pKlldNGvDix0nhYt/ix7WmbBAkdnvvK+tgfOzrBoRW/TkJWp4WsgmQf6kTvsgN8YPVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794670123;
	h=DMARC-Filter:Received:Received:Message-ID:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:X-HE-Tag:
	 X-HE-Meta;
	bh=IdKF9ajWWE9SdG7ixSWGz+NY1Pz+dGrmBk+oq/+zmmk=;
	b=wq0y9S1Yvw3Yl+qyfckUz4/6evYpuowHxU2HUbzzlBbTZPJoyTwf9X4++6mg7lYzAgrM
	 drGXBjNKCbFU17Y1FT5jzPzx5BcUVC5m2tnRBu9c01AB77rRZjMMhZM0UXzRfA5ZDYAtz
	 Trl9EHhR9UoXs+cUGgrZxeHtTmA8OGsOZ7bnJ2S4lX6+gNbjMcRNR1FNTPG/CZ3bBVjRf
	 CcD/eYHRUY/DhcgBsm0nopIyQtWYuLH0VZQDqQxCw7o2mRR/+E5YENVrNdi6M6aMbZuzX
	 EAlF/pG5AYdcQQ+4bs7/ap/D9/h6JbKruiwrMz57PGcCFO8YcwDMQbknSNA6eAtG9Vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=perches.com;
	spf=pass smtp.mailfrom=perches.com;
	arc=none smtp.remote-ip=216.40.44.13
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BB4606A329;
	Sat, 14 Nov 2026 15:28:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2BB4606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf16.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 121F940469;
	Sat, 14 Nov 2026 15:28:34 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf16.hostedemail.com (Postfix) with ESMTPA id 8B07B20013;
	Sat, 14 Nov 2026 15:28:24 +0000 (UTC)
Message-ID: <6de04b9cf2dfe9ff1dacdddc0a76752a714a991c.camel@perches.com>
Subject: Re: [PATCH v6 02/19] string: Add strprefix()
From: Joe Perches <joe@perches.com>
To: Alejandro Colomar <alx@kernel.org>, linux-hardening@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>, "Maciej W. Rozycki"	
 <macro@orcam.me.uk>, Geert Uytterhoeven <geert@linux-m68k.org>, Andreas
 Schwab	 <schwab@linux-m68k.org>, Andy Shevchenko <andy@kernel.org>, Bartosz
 Golaszewski	 <brgl@kernel.org>, Daniel Scally <djrscally@gmail.com>, Danilo
 Krummrich	 <dakr@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Hans Verkuil <hverkuil-cisco@xs4all.nl>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, Johan Hovold
 <johan@kernel.org>, Kees Cook <kees@kernel.org>, Laurent Pinchart	
 <laurent.pinchart@ideasonboard.com>, Len Brown <lenb@kernel.org>, Linus
 Torvalds <torvalds@linux-foundation.org>, Linus Walleij
 <linusw@kernel.org>, Namhyung Kim	 <namhyung@kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Rob Herring	 <robh@kernel.org>, Sakari Ailus
 <sakari.ailus@linux.intel.com>, Saravana Kannan	 <saravanak@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Tom Zanussi	 <zanussi@kernel.org>,
 linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org, Bartosz Golaszewski	
 <bartosz.golaszewski@oss.qualcomm.com>
Date: Sat, 14 Nov 2026 07:28:23 -0800
In-Reply-To: <0eaa4ce73a2b164fd49e3a9f71244a2e3f45b7bb.1794667407.git.alx@kernel.org>
References: <cover.1794667407.git.alx@kernel.org>
	 <0eaa4ce73a2b164fd49e3a9f71244a2e3f45b7bb.1794667407.git.alx@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 8B07B20013
X-Stat-Signature: sohy545iapzg9mu1uffsyoa96ixkgcx4
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/rjNiB1xWIkYfGkbQxppcMa0euToSB66c=
X-HE-Tag: 1794670104-923526
X-HE-Meta: U2FsdGVkX1/dolkWhw1Shf589fZMJNjgtV6zXq9nJEZUGEms3SUQCnZ3JqNCATugLECoNt6e6CiZSlUe7PBglwX9X9k5wbCOnNkuelofH4gqgD4MNd64vrnjJM0h/3ZFZWMFzyt7HViBur4DTsc9/GSj9DziwhWvE3q7/gC572plZNKSWL+ra7Or84ucHZcBO5AFHaQg227mpSyQkj5V46Ar/3zrsUEUgnHkHbZ2q/xhn4WMeIOCE0G9F+qJEoRlm89zHC2xiBcZbOKVfOzOWLXLHRn5E5DFmKcbDFn61cT809DS8cRDvbOalFAg/ft4

On Sat, 2026-11-14 at 16:22 +0100, Alejandro Colomar wrote:
> As Bartosz reported, str_has_prefix() has a bug: it can't differentiate
> between an empty prefix matching an empty string from a non-matching
> prefix.  This is a fundamental design flaw in this API, and not
> something that can be fixed.

I still think this description is poor.
It's neither a bug nor a flaw.
It's a design choice.
