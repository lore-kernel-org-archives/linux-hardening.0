Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795685552;
	b=uc284lS0sMzglCmjnPX4My+hB/P4cnnRkD99WSnNmJAGe70vi3gGblg1fesd7vo1RL2L
	 fNbmbxxBB+ZTBhwMTXGSEpT8fMc3HVgkcWDFsyIm13oibeRw/v2rKVWoUAPdEWHcglYNc
	 U2UkWvwBAwmnonYDkPV5vkxI3f8rYwMZ7hl7NhTtva1dkY9OzKwqLICVhruQ/EXM0y4OB
	 6/mKiLhVh6g7z5RDqS6pUIrx/PpCiXNceZJtxPW9/ZidSHcK7fhHgy+dvtHzmPfwsV9fE
	 EVWHmboWGB3V59nKY2gkNiaEIhp8b3OXuP4anHfK8i3L2xJyKsW2GBIcklMzH2jG+dA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795685552;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=k97771Z8FzE3DqumF944ddIXlJqYU9QrTeylE9F0vK8=;
	b=p7ls+HowH3x9Ioio9ZW0i7zY1Hf4j7S0ZEpeIUHf8TtonJmwqeg8bWg81nG7v/jXrgOv
	 SrK3d3z0v6J753eEj7KFtZPnrlaREi/yAb9YPAgju1EvMO2N04z5+tez/cUO2Ecd933A3
	 q9o0jTxpc2npPwyRiLZZ3LjyR738wnLdOKf317ip4qnyChlwF2gDR9UvXTotONNbhkWzf
	 PbXy/KHdCFOt5tBbgLAc8KQibmjEgNflf+Ak3uEUCZctJe8fjv/DeXnSJYbM67vjRbd6r
	 OjRIgZQXMMiAhuatfay/GUf5WHhov7D09bDWGBahiffyt3S0YXD204SnlHw1SdR+GUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="JfycLV/X";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 3C204606A31E;
	Thu, 26 Nov 2026 09:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JfycLV/X
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id A3E6D1F000C4;
	Thu, 26 Nov 2026 09:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795685551;
	bh=k97771Z8FzE3DqumF944ddIXlJqYU9QrTeylE9F0vK8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JfycLV/XA23DU9QWWbk335hn9BiFSTG2F83xPm9eihA8hYYXY61JEuiVxIQmpXR7D
	 QkDAjPTPIAa81FEZQM8o4OezkrmfkzBvLkKdkf6WZ8YAcA4xCt3CAYSE+jzEQO3vjx
	 QKrPM8JHhU5eq1Rv/Z3lKfKa/oAmWAfpTdBdqPMb4XgJ2QnDKKfcSGVPr1yLP2AP8M
	 AsxgIg3N3GkbOQTX1KtCCvtEo9Bi99M+pyhdtuIOf3MWSUroCNlSqtCy2sOeTdr25+
	 qDh97siTL+bJYJgcGXX8em4rMkNEnwMp7NMnoYJMhnnLirRPM65Xn8eMFVnaydu06O
	 zIrvK1L6hY3yg==
Date: Thu, 26 Nov 2026 10:32:28 +0100
From: Bartosz Golaszewski <brgl@kernel.org>
To: Alejandro Colomar <alx+linux-hardening@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, 
	Alejandro Colomar <alx@kernel.org>, linux-hardening@vger.kernel.org, 
	Krzysztof Kozlowski <krzk@kernel.org>, "Maciej W. Rozycki" <macro@orcam.me.uk>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Andreas Schwab <schwab@linux-m68k.org>, 
	Andy Shevchenko <andy@kernel.org>, Daniel Scally <djrscally@gmail.com>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Hans Verkuil <hverkuil-cisco@xs4all.nl>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Joe Perches <joe@perches.com>, Johan Hovold <johan@kernel.org>, Kees Cook <kees@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Len Brown <lenb@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Linus Walleij <linusw@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Rob Herring <robh@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Saravana Kannan <saravanak@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Tom Zanussi <zanussi@kernel.org>, linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v7 4/4] device property: Fix fwnode_name_eq() for empty
 node names
Message-ID: <ytxtn2ew62vxuxoinkf33gjntl33ijycjouzutlfcydkh7usm6@ad47ocprfu23>
References: <cover.1795639368.git.alx@kernel.org>
 <396395e1d02ca080da67cfd91a1c49058b2676b6.1795639368.git.alx@kernel.org>
 <awdaYz9NNVv5fHv9@ashevche-desk.local>
 <awddHt_xvc-lIygA@devuan>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <awddHt_xvc-lIygA@devuan>

On Wed, Nov 25, 2026 at 11:18:16PM +0100, Alejandro Colomar wrote:
> Hi Andy,
> 
> > Date: 2026-11-26 00:00:03+0200
> > From: Andy Shevchenko <andriy.shevchenko@intel.com>
> >
> > On Wed, Nov 25, 2026 at 10:03:55PM +0100, Alejandro Colomar wrote:
> > > str_has_prefix() returns the prefix length on match and 0 on mismatch,
> > > so the mistmatch case can't be told from "empty prefix matched an empty
> > > string".
> > > 
> > > For instance: the OF root node's name as returned by
> > > fwnode_get_name() is "" and will return 0 for any name matched against
> > > it and since len is 0 too, fwnode_name_eq() will return true.
> > > 
> > > Let's use strprefix() instead, which also makes this function simpler.
> > 
> > ...
> > 
> > > Message-ID: <avrSUUM3HMgxTNpl@kekkonen.localdomain>
> > > Message-ID: <nat4ilqmzzpuyrjbuahl367ip22tfnmjorydlppuwqiscxaujo@kf63j4lb3flk>
> > > Message-ID: <nat4ilqmzzpuyrjbuahl367ip22tfnmjorydlppuwqiscxaujo@kf63j4lb3flk>
> > 
> > What is this?
> 
> git-am(1) has --message-id and the corresponding am.messageId, which
> stores the Message-ID from the email header field from which the patch
> is taken, to document where the patch was taken from.  It is stored by
> git-am(1) right below the last trailer tag from the patch (which should
> be the 'Signed-off-by' of the author), and before the 'Signed-off-by'
> appended by git-am(1) itself.
> 
> 	$ MANWIDTH=64 man git-am | grep -A5 messageId
> 	     am.messageId
> 		 Add a Message-ID trailer based on the email header to
> 		 the commit when using git‐am(1) (see git‐interpret‐
> 		 trailers(1)). See also the --message-id and
> 		 --no-message-id options.
> 
> It's useful to document where those tags come from, in case it's
> historically useful.
> 
> I've extended its use to other tags I take from emails.
> 
> > Is it documented tag nowadays?
> 
> It is not documented in the kernel, AFAIK.  It is documented in
> git-am(1).  I included it, because I find it useful.  Feel free to drop
> it if it's not wanted (I can remove in in v8 if it's not wanted).
> 

Yeah, don't use it. In general try to stick with the tags listed in
Documentation/process/5.Posting.rst.

I've too never seen Message-ID in a commit footer before.

With those removed:

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Bart
