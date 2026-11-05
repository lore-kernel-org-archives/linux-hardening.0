Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793896044;
	b=0+TF4bcKBaUtfkkhQNepybgb4AMP86IKMY6ODraSztmxtOIPQiWYcVDxEOqCbBmK2fV+
	 VeAyTMuBDj+BFkyht2UOKzXTehpdHHdGm1CwUqwP5EX6xekc1jDgdlG44CWoUGneCZ5bk
	 7q/mep+QWoBg3a78qe2C6DrhxtK1i2ioAoDx7HV+S5ivw1Or5ANN0DVA1E90jYiRHmFqB
	 Nkbo5ajXYgDujdUVMjHmhLlVDNvL9ICmVAeihuKWTcU8DLb/7vf9a+FFwN2cfE6grMOvy
	 Bs82xSvqvKgMfVgftgPu/SCTrgQDPa+E+yTDScJS83Y7YwTennkgH/GfEMP1NG+7ZrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793896044;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=cl6qWXAwKxsVwTkKY8JXxlaaCkzuu5lHBNqnNBZkMHw=;
	b=RBZFMi7x7KAG/mCStr4WPZGvWvlqSj/PHBiD5E4CpM3wtYsHJj1iw9z+EnZe3qkegSD5
	 cJrXVWZin1IN8tRj2SDNRS6DjvxX0BgB8S2McpEYhZxrK/jpAKxEjSXAjRMvaiQzDjygc
	 ti+rDD7qZ23aAotRjsG9eBfmOoDaCYFSg3SGG/2x5p9JHLfYo41T7g2PXprYwHAHlfqw2
	 ksmQgOFtjBWXfLNkb/0kEvi4FjghKIeiEzUO6i1qdKE/JA1FikiTxEmsZmubheXYYyFFo
	 PzodAxqkk12IVZbB8oyvpH3F3UmEFD33ISPg2xp2/diRqj0WOHVdnjxe5ZmakgeEmPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=isGRszzZ;
	arc=none smtp.remote-ip=216.40.44.12
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6764606D836;
	Thu,  5 Nov 2026 16:27:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6764606D836
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=isGRszzZ
Received: from omf11.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id EF57EA0B2C;
	Thu,  5 Nov 2026 16:27:14 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id E897F2002D;
	Thu,  5 Nov 2026 16:27:08 +0000 (UTC)
Date: Thu, 5 Nov 2026 11:27:07 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Alejandro Colomar <alx+linux-hardening@kernel.org>, Bartosz Golaszewski
 <brgl@kernel.org>, Alejandro Colomar <alx@kernel.org>,
 linux-hardening@vger.kernel.org, Andreas Schwab <schwab@linux-m68k.org>,
 Andy Shevchenko <andy@kernel.org>, Daniel Scally <djrscally@gmail.com>,
 Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Hans Verkuil <hverkuil-cisco@xs4all.nl>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, Joe Perches
 <joe@perches.com>, Johan Hovold <johan@kernel.org>, Kees Cook
 <kees@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Len Brown <lenb@kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Linus Walleij <linusw@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Rob Herring <robh@kernel.org>, Sakari Ailus
 <sakari.ailus@linux.intel.com>, Saravana Kannan <saravanak@kernel.org>, Tom
 Zanussi <zanussi@kernel.org>, linux-acpi@vger.kernel.org,
 driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Add strprefix() and fix a bug with it
Message-ID: <20261105112707.3e523564@gandalf.local.home>
In-Reply-To: <5001d8c2-2334-48bd-bc95-6b33e3922a46@kernel.org>
References: <cover.1793876837.git.alx@kernel.org>
	<cover.1793882260.git.alx@kernel.org>
	<qwpovcqznx6eltou4inmj3v62qhh6ouvihqnze7bobnd7lmcbw@rcri4e623icb>
	<auyOkL1Vb1iKicS9@devuan>
	<5001d8c2-2334-48bd-bc95-6b33e3922a46@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: E897F2002D
X-Stat-Signature: 1j5wr87cyuobkeessu4smpn1kt6uqm7y
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18LWE+TJn1V15fX2nd3ghD2tOKUsGtbMPo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=cl6qWXAwKxsVwTkKY8JXxlaaCkzuu5lHBNqnNBZkMHw=; b=isGRszzZS5nfoejHUDzDLGhTBvLgv90g+WAVgonIoqoULmQosElt/YkkmtZCG/er4K4ZDKb0kvSLTzAeUcyaUu4POFEAYxPTS6kMiAlaGQ3/+yVTsb3rWeyefPXmtiZk3db+mHiAByy9IyaKv9Iky/h8qdJfJcl9UUIXaMNjsIE=
X-HE-Tag: 1793896028-287696
X-HE-Meta: U2FsdGVkX18/tmyfkjZHklw+whjWpw3EGPMbFU48rlVLVJORRKfHV20NxtljGLQ4CE8FlNIE1rUiJxJvhAu9wOEnwcNS7/wSWe42xYAVcG8z7ibSqnS3xC+4OEBmRMkEbT/1aHTTHx54xVL22ry2Y9Hi9Lc0tUuU/U096RSJ21Toj9fJN+ji6hTb6eCaoPkSDrj4n5cZm0JsW/A+rUK4rVjEJ6TqGN/yiIrtPfWVdgyekmXHJaqJalSxYxmHSQ+wC5gwzDcaKumA6i9rN4JpSe+JmQ5GvXGWboNIwn7a1LhGzSZvw5btCmyVvyIR1WY2MQV515HGAy7ca34d9q8hFBfjSl485DUR

On Thu, 5 Nov 2026 16:21:02 +0100
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> I believe there should be no excuse for modern maintainer to not use b4
> in the workflow. The same BTW for submitters of anything bigger than
> 3-patch series.

I still don't use it ;-)

That's because I have been perfectly happy with patchwork, which is where I
download my patches from.

-- Steve
