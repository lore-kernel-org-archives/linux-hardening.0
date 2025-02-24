Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9842325A645
	for <linux-hardening@vger.kernel.org>; Mon, 24 Feb 2025 16:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740413137; cv=none; b=VV+uhoeEeX4bsmNXcwTXfKJB1CZFQ8/kJ1sXIajQUnHH7VBZ5XIFPOuFUtRkk8hJJdJYULfVg9bSAbyE/ZIWypEZDrP1sZVJsYN6pph9uPCPPeboLwR12xmiVU2KVHLTkonlKiJLxoJ2f4urv4BU6VK+sjrBSchEGQpwuQ45IWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740413137; c=relaxed/simple;
	bh=nBC1j41G/L7zvVS5hmAJB3iEcotQ4hG/zkmlma8qSEk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ACo+wSQ9OyLfKOiMk5hFuPDsQLDvSWKTx1/PuhWsZTO4+PFVYFEL6pmHz37ljMs8R9lFV6D1s5oCv2oLiEbMim3gMHKrMQqDfzoQGt+wHCEaIuTHRKh1UE0QqMQQeMO916xFnLQjrrJfLBqnlW24RS7m9uL2JtTwqDgZ57dOmbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WziuymQE; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WziuymQE"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-439a4dec9d5so43826485e9.0
        for <linux-hardening@vger.kernel.org>; Mon, 24 Feb 2025 08:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740413133; x=1741017933; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nBC1j41G/L7zvVS5hmAJB3iEcotQ4hG/zkmlma8qSEk=;
        b=WziuymQEwtHIAU3efEaS1viUhPMrk04K+R3RIsXUEAu7Hpmzkw10YqZm39h1Odm6ZN
         /nAhpc7wTnYJIoUiEsKIV41s/ToWuMxc6cGrTtcqaRxr9Z83l1MvJmjEnbkW5WDQy6pV
         NGyzyjUE4Qc/U+s+X/Cz4+tuYjegZUFm+KxZzo8E0KmWJ2RfIyFnjF9RCVldENdFRyxx
         fhgvM164Oklk78n0Swgy4WM7krTSlOhZJ011uET9LxEw5Ut3jihFvW6hDWEp8fDH9yGg
         uZ+EVkjoKgeEfaUK6wpJVMCmPWeXpsOTx81yvpbm3nrswOzo1AYAlaqRy1ydRKOhkbY+
         M7Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740413133; x=1741017933;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nBC1j41G/L7zvVS5hmAJB3iEcotQ4hG/zkmlma8qSEk=;
        b=vSYTbBga7jMnZEruJzhQ/7u2GhdeTD8LPr5ZJPfkVJyVkA0EIn6sv9KnZr9Cqt6Oep
         4Yuaqn+HQhIi83NSN8eyKHC7z0fxsfpZQ4ra0wewCV8xobz713RNVCzs78oWH119Ks9f
         +2ZF08tGq3QdyRHQsX97n1Y8LsG7qyCYIRX9zMy13rKVziOxEjY9M2MmaWrCssXl9M6l
         wV+iRI7nVIStSElLJMgX8QW0PUpiJI2rRvLUzS6TFmgSGZDwCND0DQLel6upRAXX7fmF
         mv/PT14UpQiJnpmZtNyISdVv9Uwo3Jn6eMOkx8s9p+08xgTxvHZ/tBteVgtiwgOAar26
         b4uQ==
X-Forwarded-Encrypted: i=1; AJvYcCXY2XLozjLP79oPUwyxx9rinVZT3t46xfx2QWkFzpprn0970e466WqcUoQ5h2NBldVGzxE7Pesjbl+oew1KL6A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5RKf4btslVzWWq/EgLIHjVCLDvKJWaBzq9V9/TejNyepbOKeP
	ojHjpittB92X8QKhYoO4GFKBxsXYI98vNMFrlbOAVgkmHS7UIXQ9g1IFGutf7uQ=
X-Gm-Gg: ASbGncsz0WXjdJ1QwejWQj5yfZztM7z263zYCeQtOSbnH/CKGK25EhA2VOTs+3vUVkE
	/O0S8kyVyZSh+IfJGNO7dwIusQVXF92yyx2kRbNGZwTI3x/rP+/O0MVMrsOSBg0h+jXx1Q8ZO9Y
	aTT3p/FpDa1+TCD3gscdv4lEbQ59Sv2PqZImZTqkzzR4MDsYaVARsiFDjOi2wxQHFiwilc/k8mT
	Pj+4ONo8XHCy197qSAejqGSq2kn8Ui+67XBIsYY2zdObMkY9d115uh+6ixaTFXWE/ZFul4iS7I+
	pm3w+hCDXy8+rBEIieo3wFq+ep4aYQ==
X-Google-Smtp-Source: AGHT+IFoqAXLOYInSIvCrAPhaXKKLxAx657LF0U9pHiol5g2jj/77Iir5Jiqe7JIp+BuTc1YHemSDw==
X-Received: by 2002:a05:600c:4588:b0:439:94f8:fc79 with SMTP id 5b1f17b1804b1-439b5aae2c5mr120586235e9.0.1740413132610;
        Mon, 24 Feb 2025 08:05:32 -0800 (PST)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4399c5d1fe8sm89966695e9.1.2025.02.24.08.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 08:05:32 -0800 (PST)
Message-ID: <865e878e79a4e5c3a7619bedd81cc8bdb00a4914.camel@linaro.org>
Subject: Re: [PATCH 1/6] dt-bindings: mfd: add max77759 binding
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Rob Herring <robh@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski	 <brgl@bgdev.pl>, Srinivas
 Kandagatla <srinivas.kandagatla@linaro.org>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, Peter Griffin	
 <peter.griffin@linaro.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, Will
 McVicker <willmcvicker@google.com>, kernel-team@android.com,
 linux-kernel@vger.kernel.org, 	devicetree@vger.kernel.org,
 linux-gpio@vger.kernel.org, 	linux-hardening@vger.kernel.org
Date: Mon, 24 Feb 2025 16:05:29 +0000
In-Reply-To: <20250224153716.GA3137990-robh@kernel.org>
References: <20250224-max77759-mfd-v1-0-2bff36f9d055@linaro.org>
	 <20250224-max77759-mfd-v1-1-2bff36f9d055@linaro.org>
	 <20250224153716.GA3137990-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.53.2-1 
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGkgUm9iLAoKVGhhbmtzIGZvciB0aGUgcmV2aWV3IQoKT24gTW9uLCAyMDI1LTAyLTI0IGF0IDA5
OjM3IC0wNjAwLCBSb2IgSGVycmluZyB3cm90ZToKPiBPbiBNb24sIEZlYiAyNCwgMjAyNSBhdCAx
MDoyODo0OUFNICswMDAwLCBBbmRyw6kgRHJhc3ppayB3cm90ZToKPiA+IEFkZCBkZXZpY2UgdHJl
ZSBiaW5kaW5nIGZvciB0aGUgTWF4aW0gTUFYNzc3NTkgY29tcGFuaW9uIFBNSUMgZm9yIFVTQgo+
ID4gVHlwZS1DIGFwcGxpY2F0aW9ucy4KPiA+IAo+ID4gVGhlIE1BWDc3NzU5IGluY2x1ZGVzIEJh
dHRlcnkgQ2hhcmdlciwgRnVlbCBHYXVnZSwgdGVtcGVyYXR1cmUgc2Vuc29ycywKPiA+IFVTQiBU
eXBlLUMgUG9ydCBDb250cm9sbGVyIChUQ1BDKSwgTlZNRU0sIGFuZCBhIEdQSU8gZXhwYW5kZXIu
Cj4gPiAKPiA+IFRoaXMgZGVzY3JpYmVzIHRoZSBjb3JlIG1mZCBkZXZpY2UuCj4gPiAKPiA+IFNp
Z25lZC1vZmYtYnk6IEFuZHLDqSBEcmFzemlrIDxhbmRyZS5kcmFzemlrQGxpbmFyby5vcmc+Cj4g
PiAtLS0KPiA+IMKgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvbWZkL21heGltLG1heDc3NzU5Lnlh
bWzCoMKgwqAgfCAxMDQgKysrKysrKysrKysrKysrKysrKysrCj4gPiDCoE1BSU5UQUlORVJTwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDYgKysKPiA+IMKgMiBmaWxlcyBjaGFuZ2VkLCAxMTAg
aW5zZXJ0aW9ucygrKQo+ID4gCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL21mZC9tYXhpbSxtYXg3Nzc1OS55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL21mZC9tYXhpbSxtYXg3Nzc1OS55YW1sCj4gPiBuZXcgZmlsZSBtb2Rl
IDEwMDY0NAo+ID4gaW5kZXggMDAwMDAwMDAwMDAwLi4xZWZiODQxMjg5ZmIKPiA+IC0tLSAvZGV2
L251bGwKPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZmQvbWF4
aW0sbWF4Nzc3NTkueWFtbAo+ID4gQEAgLTAsMCArMSwxMDQgQEAKPiA+ICsjIFNQRFgtTGljZW5z
ZS1JZGVudGlmaWVyOiAoR1BMLTIuMC1vbmx5IE9SIEJTRC0yLUNsYXVzZSkKPiA+ICslWUFNTCAx
LjIKPiA+ICstLS0KPiA+ICskaWQ6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL21mZC9t
YXhpbSxtYXg3Nzc1OS55YW1sIwo+ID4gKyRzY2hlbWE6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9t
ZXRhLXNjaGVtYXMvY29yZS55YW1sIwo+ID4gKwo+ID4gK3RpdGxlOiBNYXhpbSBJbnRlZ3JhdGVk
IE1BWDc3NzU5IFBNSUMgZm9yIFVTQiBUeXBlLUMgYXBwbGljYXRpb25zCj4gPiArCj4gPiArbWFp
bnRhaW5lcnM6Cj4gPiArwqAgLSBBbmRyw6kgRHJhc3ppayA8YW5kcmUuZHJhc3ppa0BsaW5hcm8u
b3JnPgo+ID4gKwo+ID4gK2Rlc2NyaXB0aW9uOiB8Cj4gPiArwqAgVGhpcyBpcyBhIHBhcnQgb2Yg
ZGV2aWNlIHRyZWUgYmluZGluZ3MgZm9yIHRoZSBNQVg3Nzc1OSBjb21wYW5pb24gUG93ZXIKPiA+
ICvCoCBNYW5hZ2VtZW50IElDIGZvciBVU0IgVHlwZS1DIGFwcGxpY2F0aW9ucy4KPiA+ICsKPiA+
ICvCoCBUaGUgTUFYNzc3NTkgaW5jbHVkZXMgQmF0dGVyeSBDaGFyZ2VyLCBGdWVsIEdhdWdlLCB0
ZW1wZXJhdHVyZSBzZW5zb3JzLCBVU0IKPiA+ICvCoCBUeXBlLUMgUG9ydCBDb250cm9sbGVyIChU
Q1BDKSwgTlZNRU0sIGFuZCBhIEdQSU8gZXhwYW5kZXIuCj4gPiArCj4gPiArcHJvcGVydGllczoK
PiA+ICvCoCBjb21wYXRpYmxlOgo+ID4gK8KgwqDCoCBjb25zdDogbWF4aW0sbWF4Nzc3NTkKPiA+
ICsKPiA+ICvCoCBpbnRlcnJ1cHRzOgo+ID4gK8KgwqDCoCBtYXhJdGVtczogMQo+ID4gKwo+ID4g
K8KgIGludGVycnVwdC1jb250cm9sbGVyOiB0cnVlCj4gPiArCj4gPiArwqAgIiNpbnRlcnJ1cHQt
Y2VsbHMiOgo+ID4gK8KgwqDCoCBjb25zdDogMgo+ID4gKwo+ID4gK8KgIGdwaW8tY29udHJvbGxl
cjogdHJ1ZQo+ID4gKwo+ID4gK8KgICIjZ3Bpby1jZWxscyI6Cj4gPiArwqDCoMKgIGNvbnN0OiAy
Cj4gPiArCj4gPiArwqAgZ3BpbzoKPiA+ICvCoMKgwqAgJHJlZjogL3NjaGVtYXMvZ3Bpby9tYXhp
bSxtYXg3Nzc1OS1ncGlvLnlhbWwKPiA+ICsKPiA+ICvCoCByZWc6Cj4gPiArwqDCoMKgIG1heEl0
ZW1zOiAxCj4gPiArCj4gPiArwqAgcG1pYy1udm1lbToKPiAKPiBKdXN0ICdudm1lbScKClRCSCwg
SSdkIHByZWZlciB0aGF0IGFzIHdlbGwsIGFuZCBJIGhhZCBqdXN0ICdudm1lbScgaW5pdGlhbGx5
LApidXQgdGhhdCBkb2Vzbid0IHdvcms6CgouLi4vbWF4aW0sbWF4Nzc3NTkuZXhhbXBsZS5kdGI6
IHBtaWNANjY6IG52bWVtOiB7J2NvbXBhdGlibGUnOiBbJ21heGltLG1heDc3NzU5LW52bWVtJ10s
ICdudm1lbS1sYXlvdXQnOiB7J2NvbXBhdGlibGUnOiBbJ2ZpeGVkLQpsYXlvdXQnXSwgJyNhZGRy
ZXNzLWNlbGxzJzogMSwgJyNzaXplLWNlbGxzJzogMSwgJ3JlYm9vdC1tb2RlQDAnOiB7J3JlZyc6
IFtbMCwgNF1dfSwgJ2Jvb3QtcmVhc29uQDQnOiB7J3JlZyc6IFtbNCwgNF1dfSwKJ3NodXRkb3du
LXVzZXItZmxhZ0A4JzogeydyZWcnOiBbWzgsIDFdXX0sICdyc29jQDEwJzogeydyZWcnOiBbWzEw
LCAyXV19fX0gaXMgbm90IG9mIHR5cGUgJ2FycmF5JwoJZnJvbSBzY2hlbWEgJGlkOiBodHRwOi8v
ZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9udm1lbS9udm1lbS1jb25zdW1lci55YW1sIwoKSSBkb24n
dCBrbm93IGlmIHRoaXMgY2FuIGJlIG1hZGUgdG8gd29yaywgaS5lLiBjYW4geW91IGhhdmUgYm90
aAppbiB5YW1sPyBDYW4gYSB0eXBlIGJlIGRlY2xhcmVkIGFzIGEgb25lT2Ygb3Igc29tZXRoaW5n
IGxpa2UgdGhhdD8KCgo+IAo+ID4gK8KgwqDCoCAkcmVmOiAvc2NoZW1hcy9udm1lbS9tYXhpbSxt
YXg3Nzc1OS1udm1lbS55YW1sCj4gPiArCj4gPiArcmVxdWlyZWQ6Cj4gPiArwqAgLSBjb21wYXRp
YmxlCj4gPiArwqAgLSBpbnRlcnJ1cHRzCj4gPiArwqAgLSByZWcKPiA+ICsKPiA+ICthZGRpdGlv
bmFsUHJvcGVydGllczogZmFsc2UKPiA+ICsKPiA+ICtleGFtcGxlczoKPiA+ICvCoCAtIHwKPiA+
ICvCoMKgwqAgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2ludGVycnVwdC1jb250cm9sbGVyL2lycS5o
Pgo+ID4gKwo+ID4gK8KgwqDCoCBpMmMgewo+ID4gK8KgwqDCoMKgwqDCoMKgICNhZGRyZXNzLWNl
bGxzID0gPDE+Owo+ID4gK8KgwqDCoMKgwqDCoMKgICNzaXplLWNlbGxzID0gPDA+Owo+ID4gKwo+
ID4gK8KgwqDCoMKgwqDCoMKgIHBtaWNANjYgewo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
Y29tcGF0aWJsZSA9ICJtYXhpbSxtYXg3Nzc1OSI7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCByZWcgPSA8MHg2Nj47Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpbnRlcnJ1cHRzLWV4
dGVuZGVkID0gPCZncGE4IDMgSVJRX1RZUEVfTEVWRUxfTE9XPjsKPiA+ICsKPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGludGVycnVwdC1jb250cm9sbGVyOwo+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgI2ludGVycnVwdC1jZWxscyA9IDwyPjsKPiA+ICsKPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGdwaW8gewo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb21w
YXRpYmxlID0gIm1heGltLG1heDc3NzU5LWdwaW8iOwo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBncGlvLWNvbnRyb2xsZXI7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgICNncGlvLWNlbGxzID0gPDI+Owo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBpbnRlcnJ1cHQtY29udHJvbGxlcjsKPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgI2ludGVycnVwdC1jZWxscyA9IDwyPjsKPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIH07Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwbWljLW52
bWVtIHsKPiAKPiBudm1lbSB7CgpkaXRvCgpDaGVlcnMsCkFuZHJlJwoKCj4gPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbXBhdGlibGUgPSAibWF4aW0sbWF4Nzc3NTktbnZtZW0i
Owo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBudm1lbS1sYXlvdXQg
ewo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbXBhdGlibGUg
PSAiZml4ZWQtbGF5b3V0IjsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCAjYWRkcmVzcy1jZWxscyA9IDwxPjsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCAjc2l6ZS1jZWxscyA9IDwxPjsKPiA+ICsKPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZWJvb3QtbW9kZUAwIHsKPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJlZyA9IDwweDAgMHg0PjsKPiA+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9Owo+ID4gKwo+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJvb3QtcmVhc29uQDQgewo+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmVnID0gPDB4
NCAweDQ+Owo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH07Cj4g
PiArCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2h1dGRvd24t
dXNlci1mbGFnQDggewo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgcmVnID0gPDB4OCAweDE+Owo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIH07Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgcnNvY0AxMCB7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCByZWcgPSA8MHhhIDB4Mj47Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgfTsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
fTsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH07Cj4gPiArwqDCoMKgwqDCoMKgwqAgfTsK
PiA+ICvCoMKgwqAgfTsKPiA+IGRpZmYgLS1naXQgYS9NQUlOVEFJTkVSUyBiL01BSU5UQUlORVJT
Cj4gPiBpbmRleCBmMDc2MzYwY2UzYzYuLmYyYzE5YTFiNGMwNSAxMDA2NDQKPiA+IC0tLSBhL01B
SU5UQUlORVJTCj4gPiArKysgYi9NQUlOVEFJTkVSUwo+ID4gQEAgLTE0MzIyLDYgKzE0MzIyLDEy
IEBAIEY6CURvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZmQvbWF4aW0sbWF4Nzc3
MTQueWFtbAo+ID4gwqBGOglkcml2ZXJzL21mZC9tYXg3NzcxNC5jCj4gPiDCoEY6CWluY2x1ZGUv
bGludXgvbWZkL21heDc3NzE0LmgKPiA+IMKgCj4gPiArTUFYSU0gTUFYNzc3NTkgUE1JQyBNRkQg
RFJJVkVSCj4gPiArTToJQW5kcsOpIERyYXN6aWsgPGFuZHJlLmRyYXN6aWtAbGluYXJvLm9yZz4K
PiA+ICtMOglsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnCj4gPiArUzoJTWFpbnRhaW5lZAo+
ID4gK0Y6CURvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy8qL21heGltLG1heDc3NzU5
Ki55YW1sCj4gPiArCj4gPiDCoE1BWElNIE1BWDc3ODAyIFBNSUMgUkVHVUxBVE9SIERFVklDRSBE
UklWRVIKPiA+IMKgTToJSmF2aWVyIE1hcnRpbmV6IENhbmlsbGFzIDxqYXZpZXJAZG93aGlsZTAu
b3JnPgo+ID4gwqBMOglsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnCj4gPiAKPiA+IC0tIAo+
ID4gMi40OC4xLjY1OC5nNDc2NzI2NmViNC1nb29nCj4gPiAKCg==

