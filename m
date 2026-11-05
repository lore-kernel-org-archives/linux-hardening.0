Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793895275;
	b=wUkIsQV/78nkfaK07DePGb9fpUHBshIWQA/HRu/Rb4GXzwgaWswj6gAmJ7bst46c8FKK
	 nZybFEvHQsPP2Bq2mOuoNylgrTLO+LVE1P3bujToads1/n34JiUW/YJMocRH++h0yW744
	 9MsqJOqvdan3RBvccNUtfnKhIdhBcc3M243LHgRuRhTFk3PnF9ckqZeM0OE/a8JjWa2eY
	 iz/UE4Ej0ImWbGOrcVeuTabigRbEDCYi5Oj+YyPUMT/t/1Tuzro4iK0U6xBjWRvrIDwcS
	 qW10LKpbmzmcFsDIZ5G7NNE7PbSU9Wg+a4J5kCeyG6cG2wv4iIrJrLovjaMUBeyduhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793895275;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=TlUJgWbu4oWGG2rIsrlDGpx3BkgzAGEHnQrvA+cmu/I=;
	b=2uMyG39qqpPGxADUjzePLcPVlm2X7gADiJvMwLePaRFDv2ajNChzwnFwtAbUPTssokFu
	 SuIwbeTgjmiYh+E1DpPM7W21XyOexmlzsI0w2Qgx2deCADrPGFuRElI31uvwVcGy/rc6U
	 RIYTQ+sYNnWmEfzIRETPPlmyLdXEM1Cv5IIXyVtMebf/5R6+4VnRLPCpnAzacRC9T2REt
	 SGe2KT0q/q1L4cgvQmdT1/QnYhwJVj8ZbO+sqPk4s3thfgMoBi/x/jM0x8zAfi0jBMX97
	 4pNIawIrz8stbzz0OsaPYi7mym1Mfrdsg4iivtf+pMkN5a1Yp5Cdoc58eEoRqaBDMOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=Nrt87YtL;
	arc=none smtp.remote-ip=216.40.44.11
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C0B606A32C;
	Thu,  5 Nov 2026 16:14:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6C0B606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=Nrt87YtL
Received: from omf16.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id EB70B120A7D;
	Thu,  5 Nov 2026 16:14:30 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id D50E92001C;
	Thu,  5 Nov 2026 16:14:24 +0000 (UTC)
Date: Thu, 5 Nov 2026 11:14:23 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-hardening@vger.kernel.org, alx+linux-hardening@kernel.org, Bartosz
 Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Andreas Schwab
 <schwab@linux-m68k.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Andy Shevchenko <andy@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, Daniel Scally <djrscally@gmail.com>,
 Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Hans Verkuil <hverkuil-cisco@xs4all.nl>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, Joe Perches
 <joe@perches.com>, Johan Hovold <johan@kernel.org>, Kees Cook
 <kees@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Len Brown <lenb@kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Linus Walleij <linusw@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Rob Herring <robh@kernel.org>, Sakari Ailus
 <sakari.ailus@linux.intel.com>, Saravana Kannan <saravanak@kernel.org>,
 linux-acpi@vger.kernel.org, driver-core@lists.linux.dev,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-gpio@vger.kernel.org
Subject: Re: [PATCH v1 1/2] string: Add strprefix(), and deprecate
 str_has_prefix()
Message-ID: <20261105111423.360f4ba8@gandalf.local.home>
In-Reply-To: <9c81f6f62fd0e908e683c4c08b09a1f95bc2ec9c.1793876837.git.alx@kernel.org>
References: <cover.1793876837.git.alx@kernel.org>
	<9c81f6f62fd0e908e683c4c08b09a1f95bc2ec9c.1793876837.git.alx@kernel.org>
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
X-Rspamd-Queue-Id: D50E92001C
X-Stat-Signature: re8d5pkjrgf4w6oyde7458ed8r8qxghn
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX180OMWVvz7pZZGYzhX+zu43VxGyggjBmUw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=TlUJgWbu4oWGG2rIsrlDGpx3BkgzAGEHnQrvA+cmu/I=; b=Nrt87YtLalkWkst5vwjAiRvM24+Ip9K7Q0HUKV2DGTKMQUiy7WgDwuuBYuCpd/0j2YF79k4RIZfBxZ0ajTmC4QvrtMR85cJ07ejGEpIrNs7u36+hESqobejHExonFkIUVIwnKekabxqGfkq61A/Cf1AQv4puRi0igIKLqRLlqbI=
X-HE-Tag: 1793895264-672208
X-HE-Meta: U2FsdGVkX1+vyVPZLQAZdLNS2wyT3JFId0OxXMm7K3LLPGSNyXEiNc0thgtN3v3LejPo/orfLtSJgneGWrAQWhq6JsVJ15veWMPwEVD3iQCpVEXA2MSVChPtf628ymAh2CtwttILHqREF05f7aEZTnW+NHNMSYhrbnFYZv9WbIqnaMC/vVDEZKHuzI/0li2WHWRC8VY/F8P3XtLBn9LsKD8hIuTBDMdrPd7VWQfSHDzNb+oM9iz27j1TazkkcbfpyskgcXy9G+JGQDHWbLBhXJaefWGPkUp0e0321tBVV3Cu/DjOBatTtfTn4TsKiR0R2ZYrJKN9V/tgrCtDf4myomhGQ3wRJRrw0x6vY/VS4PausVqHJ43w8g==

On Thu, 5 Nov 2026 12:13:03 +0100
Alejandro Colomar <alx@kernel.org> wrote:

> As Bartosz reported, str_has_prefix() has a bug: it can't differentiate
> between an empty prefix matching an empty string from a non-matching
> prefix.  This is a fundamental design flaw in this API, and not
> something that can be fixed.
> 
> As always, this is a consequence of choosing sizes instead of pointers.
> Sizes are often the wrong choice.  In this specific case, pointers are
> more capable of differentiating these cases, as NULL is a special
> sentinel value that doesn't need to overload a valid value.
> 
> Let's implement strprefix(), a function that returns a pointer
> right after the prefix if found, and a null pointer if not found.
> 
> We'll slowly migrate existing code from str_has_prefix() to strprefix().
> 
> Reported-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Is there a link to the report? Please add that.

>  
> +/**
> + * strprefix - string prefix
> + * @s: The string to be tested
> + * @prefix: The string to see if @s starts with
> + *

Needs a better description. Feel free to use the one for str_has_prefix().


> + * Returns:
> + * *  @s+strlen(@prefix) if @s starts with @prefix
> + * *  NULL if @s does not start with @prefix
> + */
> +static __always_inline char *strprefix(const char *s, const char *prefix)
> +{
> +	size_t len = strlen(prefix);
> +	return strncmp(s, prefix, len) == 0 ? (char *) s + len : NULL;
> +}
> +
>  /**
>   * str_has_prefix - Test if a string has a given prefix
>   * @str: The string to test
>   * @prefix: The string to see if @str starts with
>   *
> + * DEPRECATED: Use strprefix()

No, it is still useful. Converting trace_event_filter() to strprefix()
would be very painful, and likely error prone.

> + *
>   * A common way to test a prefix of a string is to do:
>   *  strncmp(str, prefix, sizeof(prefix) - 1)
>   *
>   * But this can lead to bugs due to typos, or if prefix is a pointer
> - * and not a constant. Instead use str_has_prefix().
> + * and not a constant. Instead use strprefix().

The above can be replaced with:

 * This is useful for testing for a prefix and returning the length.
 * If you only need to test the prefix and perhaps get the pointer to the
 * position of the string after the prefix, then use strprefix().

-- Steve


>   *
>   * Returns:
>   * * strlen(@prefix) if @str starts with @prefix

