Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794759362;
	b=Z1Fqf8u+MHNeLB4NOfBJMrgpa6AClaBestbBSGQF7iEtYV1iWFNrZDUjdutvt9KT+kvT
	 F2reGjb9q9eNfyvGq/ReVPhFbD4/PAicu4TMIlIdn+syJwwSZTMspFPOnQc75+HfuC2uW
	 nTKE8EdXZEHr6tP2HE0mdWcTDNtL01SYLZfI0VqykrxoYayOolmuxSscvp/2dLV0C7qe4
	 Y4AOBYbms8MJ5QZlVRWcGCnBw6OKrlJsLxAlSEW7RaelOPAVaF1fKr2mv4ZBRQzx/oCs9
	 MxWhjmK6rzxNcshia9sQ4xcxeTOuM7FYYnty1xHItXaJGnal/+yWoepfKnLh8DXLKhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794759362;
	h=DMARC-Filter:Received:Received:Message-ID:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version:X-Stat-Signature:X-Spam-Status:
	 X-Rspamd-Server:X-Rspamd-Queue-Id:X-Session-Marker:X-Session-ID:
	 X-HE-Tag:X-HE-Meta;
	bh=y1SyaCbxPgxUqPKDIPzlhYz46szeJkR1Qe7QsbB6fso=;
	b=drnv0suRgAx7Mku4nNImh0T9mm7L88IsATN0azzTGCuEugcM5yDrvyQlmlzVjp1Mt/lm
	 ADqFghD7Yj/9P1iTKWGdqRYOi376V4adEaTJV5DT4UatOhWEAwriFpT4SD0CmlvJMkbcf
	 /g/xu3u6NQZdCCKWW04OCBZs/qU/HMe7HLZ4dupaxhC6doZ1bVCGhsWMXzyEMndXrVL6D
	 KDX4/BHhNpe21T7esUbeBktb6INTdz7EMDqzHpQl9j942gk2xYOY3Z7g97HmCw93g0jRq
	 NkR+t/CyPFbzRukIzdl2izz4iXvlpp2hPES1Bu9mJTmlls2UDJEIXUIpUtwNZXjsoaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=perches.com;
	spf=pass smtp.mailfrom=perches.com;
	arc=none smtp.remote-ip=216.40.44.16
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E0C606A31F;
	Sun, 15 Nov 2026 16:16:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3E0C606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf19.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 71263C07F4;
	Sun, 15 Nov 2026 16:15:55 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf19.hostedemail.com (Postfix) with ESMTPA id BCC1A20025;
	Sun, 15 Nov 2026 16:15:53 +0000 (UTC)
Message-ID: <43c991a975d649c11706714e05ab9bd438e0d7d5.camel@perches.com>
Subject: Re: [PATCH v6 18/19] treewide: s/\<strends\>/strsuffix/g
From: Joe Perches <joe@perches.com>
To: Alejandro Colomar <alx@kernel.org>, linux-hardening@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Date: Sun, 15 Nov 2026 08:15:52 -0800
In-Reply-To: <3cad861d30901777d9bdafec1ccf113e0a3fcfa7.1794667407.git.alx@kernel.org>
References: <cover.1794667407.git.alx@kernel.org>
	 <3cad861d30901777d9bdafec1ccf113e0a3fcfa7.1794667407.git.alx@kernel.org>
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
X-Stat-Signature: r19jq57b5fooramtpn76iatrj36ksds7
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: BCC1A20025
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX182ECguAhdUhQpHiucwxJWxrPvpXC04QtQ=
X-HE-Tag: 1794759353-214076
X-HE-Meta: U2FsdGVkX1/FXeh89E7cosGKxXXZcZjwTNVlP4Y681zLNS9/CqaaXEeufAhYwqLsfNXonTRTZYSXtNOZyByrCzeKKa7RUf9BKjWW9Gc+naFC2NfGcCwxFQJsXs9h3SALRbT0sQw2uK3vBYHZfLW2kPH25Drhj/CYd/X4S7qwqbN4mC77SlS7tl9svN//Dco/w0Q2YVsD1CEfltPi4ft2XPgH95AjSRE1t6wjiU9Jjyer7rFrHi194jbpL6iF2xXmPxxnBliN/RvqMuWBd9vkErr81scgeohcxlQ/4B3hC07LqzXENBZvW+1BShacR0+Cmlp5DTBWyLRCbSBpPfxAdDAl6bwm3pzio8VKwWq1kKbaCFLByFJHDDWfgSgVGtXPRxQoWrN2wet3NqLOjeGGXQ==

On Sat, 2026-11-14 at 16:24 +0100, Alejandro Colomar wrote:
> Except for the changes to "lib/tests/string_kunit.c", this was
> a scripted change:
>=20
> 	$ git ls-files \
> 	| grep '\.[ch]$' \
> 	| grep -v -e ^tools/ -e ^scripts/ -e ^include/ \
> 	| xargs grep -l strends \
> 	| xargs sed -i 's/strends/strsuffix/g';

You should really use coccinelle (spatch)
and this should probably be 2 patches.

https://coccinelle.gitlabpages.inria.fr/website/docs/main_grammar016.html

something like:

@@
expression a1;
expression a2;
@@

-	strends(a1, a2)
+	strsuffix(a1, a2)
