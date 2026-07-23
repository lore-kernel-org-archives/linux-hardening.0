Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10610276041;
	Thu, 23 Jul 2026 09:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784798212; cv=none; b=ZKv4Rw/2dUVUiwCca6FFvpj4vg66kouGIkuI/5Cureh5Zjq+cs4uVxaldLBP6lCG9rmUtIYl7weDtqxQLVZWACr4yEYFqayEZpO9QCM0HTXfLlcvummh+MobZWf620kDf4EPQXC4iG4QiTKM5Z88hkYXGR1CCp56H2eV7cOJXXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784798212; c=relaxed/simple;
	bh=VOrdna3rc5MGzEyHZOfg1PRpiV7aR13Kdfhv2THJYk0=;
	h=Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=NnUyo4mLgFKHmq6TSIPsRU+cQikEFSXmdPDdFb3WaYarrV5ZULVlcnhdU1oRCWrxmxhqgZUAYq8xP4EN/JSq3YLu3XleLK1PuaNfP4te/dyy/oj/1pJ86+oX9obqJG8oELTssKwDfdGDOBP36jkASeUZZesIHeuqML1GIG/mIYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4h5QVC69YNz8XrrJ;
	Thu, 23 Jul 2026 17:16:35 +0800 (CST)
Received: from szxlzmapp04.zte.com.cn ([10.5.231.166])
	by mse-fl1.zte.com.cn with SMTP id 66N9GRW9057348;
	Thu, 23 Jul 2026 17:16:27 +0800 (+08)
	(envelope-from gao.rui@zte.com.cn)
Received: from mapi (szxlzmapp04[null])
	by mapi (Zmail) with MAPI id mid12;
	Thu, 23 Jul 2026 17:16:30 +0800 (CST)
X-Zmail-TransId: 2b066a61dbeec88-2473c
X-Mailer: Zmail v1.0
Message-ID: <20260723171630215RPj7rpUxqQL0BGzF2t6uL@zte.com.cn>
In-Reply-To: <3355f1cc-4059-475e-9e52-4bca9b10ed98@kylinos.cn>
References: 20260722064037.1111467-1-gao.rui@zte.com.cn,20260722064037.1111467-3-gao.rui@zte.com.cn,3355f1cc-4059-475e-9e52-4bca9b10ed98@kylinos.cn
Date: Thu, 23 Jul 2026 17:16:30 +0800 (CST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <gao.rui@zte.com.cn>
To: <jiangfeng@kylinos.cn>
Cc: <pjw@kernel.org>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <alex@ghiti.fr>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kees@kernel.org>, <andy@kernel.org>,
        <linux-hardening@vger.kernel.org>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAyLzJdIGt1bml0OiBzdHJpbmc6IGFkZCBzdHJubGVuIFNJWkVfTUFYIHRlc3QgY292ZXJhZ2U=?=
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL:mse-fl1.zte.com.cn 66N9GRW9057348
X-TLS: YES
X-ENVELOPE-SENDER: gao.rui@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Thu, 23 Jul 2026 17:16:35 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A61DBF3.001/4h5QVC69YNz8XrrJ



--=====_001_next=====
Content-Type: multipart/related;
	boundary="=====_002_next====="


--=====_002_next=====
Content-Type: multipart/alternative;
	boundary="=====_003_next====="


--=====_003_next=====
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64

PiBFeHRlbmQgc3RyaW5nX3Rlc3Rfc3RybmxlbiB0byB2YWxpZGF0ZSBzdHJubGVuIGJlaGF2aW9y
IHdpdGgKPiBTSVpFX01BWCBpbnB1dDoKPiAuLi4KPiArICAgICAgICAgICAgLyogVGVzdCBDb3Vu
dCBvdmVyZmxvdyBmYWxsYmFjayAqLwo+ICsgICAgICAgICAgICBLVU5JVF9FWFBFQ1RfRVEodGVz
dCwgc3RybmxlbihzLCBTU0laRV9NQVgpLCBsZW4pOwoKT24gMjAyNi83LzIyIDE1OjEwLCBGZW5n
IEppYW5nIHdyb3RlOgo+IEEgc2ltaWxhciBwYXRjaCBoYXMgYWxyZWFkeSBiZWVuIHN1Ym1pdHRl
ZDoKPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNjA1MjYwODU5MTMuNDI5MDQ5LTEt
bWluX2hhbG9AMTYzLmNvbS8KClRoYW5rcyBmb3IgdGhlIHBvaW50ZXIuCgpJIGNoZWNrZWQgdGhh
dCBlYXJsaWVyIHBhdGNoLCBidXQgaXQgZG9lcyBub3QgYWN0dWFsbHkgY292ZXIgdGhlICoqQ291
bnQgb3ZlcmZsb3cqKiBjYXNlLiAgClNwZWNpZmljYWxseSwgaXQgb25seSB0ZXN0cyB3aXRoIGBT
SVpFX01BWGAsIHdoaWxlIG15IHBhdGNoIGFkZHMgYW4gZXhwbGljaXQgY2FzZSBmb3IgYHN0cm5s
ZW4ocywgU0laRV9NQVgpYC4gIAoKClNvIG15IHBhdGNoIGNvbXBsZW1lbnRzIHRoZSBleGlzdGlu
ZyBvbmUgYnkgZXh0ZW5kaW5nIEtVbml0IGNvdmVyYWdlIHRvIHRoaXMgZXh0cmVtZSBpbnB1dC4K
Ci0tCgpCZXN0IHJlZ2FyZHMsICAKR2FvIFJ1aQ==


--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBjbGFzcz0iemNvbnRlbnRSb3ciPjxwcmU+Jmd0OyZuYnNwO0V4dGVuZCZuYnNwO3N0cmlu
Z190ZXN0X3N0cm5sZW4mbmJzcDt0byZuYnNwO3ZhbGlkYXRlJm5ic3A7c3RybmxlbiZuYnNwO2Jl
aGF2aW9yJm5ic3A7d2l0aAomZ3Q7Jm5ic3A7U0laRV9NQVgmbmJzcDtpbnB1dDoKJmd0OyZuYnNw
Oy4uLgomZ3Q7Jm5ic3A7KyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOy8qJm5ic3A7VGVzdCZuYnNwO0NvdW50Jm5i
c3A7b3ZlcmZsb3cmbmJzcDtmYWxsYmFjayZuYnNwOyovCiZndDsmbmJzcDsrJm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7S1VOSVRfRVhQRUNUX0VRKHRlc3QsJm5ic3A7c3RybmxlbihzLCZuYnNwO1NTSVpFX01BWCks
Jm5ic3A7bGVuKTsKCk9uJm5ic3A7MjAyNi83LzIyJm5ic3A7MTU6MTAsJm5ic3A7RmVuZyZuYnNw
O0ppYW5nJm5ic3A7d3JvdGU6CiZndDsmbmJzcDtBJm5ic3A7c2ltaWxhciZuYnNwO3BhdGNoJm5i
c3A7aGFzJm5ic3A7YWxyZWFkeSZuYnNwO2JlZW4mbmJzcDtzdWJtaXR0ZWQ6CiZndDsmbmJzcDto
dHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNjA1MjYwODU5MTMuNDI5MDQ5LTEtbWluX2hh
bG9AMTYzLmNvbS8KClRoYW5rcyZuYnNwO2ZvciZuYnNwO3RoZSZuYnNwO3BvaW50ZXIuCgpJJm5i
c3A7Y2hlY2tlZCZuYnNwO3RoYXQmbmJzcDtlYXJsaWVyJm5ic3A7cGF0Y2gsJm5ic3A7YnV0Jm5i
c3A7aXQmbmJzcDtkb2VzJm5ic3A7bm90Jm5ic3A7YWN0dWFsbHkmbmJzcDtjb3ZlciZuYnNwO3Ro
ZSZuYnNwOyoqQ291bnQmbmJzcDtvdmVyZmxvdyoqJm5ic3A7Y2FzZS4mbmJzcDsmbmJzcDsKU3Bl
Y2lmaWNhbGx5LCZuYnNwO2l0Jm5ic3A7b25seSZuYnNwO3Rlc3RzJm5ic3A7d2l0aCZuYnNwO2BT
SVpFX01BWGAsJm5ic3A7d2hpbGUmbmJzcDtteSZuYnNwO3BhdGNoJm5ic3A7YWRkcyZuYnNwO2Fu
Jm5ic3A7ZXhwbGljaXQmbmJzcDtjYXNlJm5ic3A7Zm9yJm5ic3A7YHN0cm5sZW4ocywmbmJzcDtT
SVpFX01BWClgLiZuYnNwOyZuYnNwOwoKClNvJm5ic3A7bXkmbmJzcDtwYXRjaCZuYnNwO2NvbXBs
ZW1lbnRzJm5ic3A7dGhlJm5ic3A7ZXhpc3RpbmcmbmJzcDtvbmUmbmJzcDtieSZuYnNwO2V4dGVu
ZGluZyZuYnNwO0tVbml0Jm5ic3A7Y292ZXJhZ2UmbmJzcDt0byZuYnNwO3RoaXMmbmJzcDtleHRy
ZW1lJm5ic3A7aW5wdXQuCgotLQoKQmVzdCZuYnNwO3JlZ2FyZHMsJm5ic3A7Jm5ic3A7CkdhbyZu
YnNwO1J1aTwvcHJlPjxkaXYgc3R5bGU9ImZvbnQtc2l6ZToxNHB4O2ZvbnQtZmFtaWx5OuW+rui9
r+mbhem7kSxNaWNyb3NvZnQgWWFIZWk7bGluZS1oZWlnaHQ6MS41Ij48YnI+PC9kaXY+PGRpdiBz
dHlsZT0iZm9udC1zaXplOjE0cHg7Zm9udC1mYW1pbHk65b6u6L2v6ZuF6buRLE1pY3Jvc29mdCBZ
YUhlaTtsaW5lLWhlaWdodDoxLjUiPjxicj48L2Rpdj48ZGl2IHN0eWxlPSJmb250LXNpemU6MTRw
eDtmb250LWZhbWlseTrlvq7ova/pm4Xpu5EsTWljcm9zb2Z0IFlhSGVpO2xpbmUtaGVpZ2h0OjEu
NSI+PGJyPjwvZGl2PjxkaXYgc3R5bGU9ImZvbnQtc2l6ZToxNHB4O2ZvbnQtZmFtaWx5OuW+rui9
r+mbhem7kSxNaWNyb3NvZnQgWWFIZWk7bGluZS1oZWlnaHQ6MS41Ij48YnI+PC9kaXY+PGRpdiB1
bm9uYW1lZW49IkdhbyBSdWkxMDA2NDc0OCIgdW5vbmFtZWNoPSLpq5jnnb8xMDA2NDc0OCIgc3R5
bGU9ImxpbmUtaGVpZ2h0OjEuNSIgY2xhc3M9InpNYWlsU2lnbiI+PC9kaXY+PGRpdiBzdHlsZT0i
bGluZS1oZWlnaHQ6MS41IiBjbGFzcz0iek1haWxGcm9tIj48L2Rpdj48L2Rpdj4=


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--

